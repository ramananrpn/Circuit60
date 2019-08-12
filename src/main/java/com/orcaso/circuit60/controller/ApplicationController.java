package com.orcaso.circuit60.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.orcaso.circuit60.model.*;
import com.orcaso.circuit60.repository.GymRepository;
import com.orcaso.circuit60.repository.TemplateRepository;
import com.orcaso.circuit60.repository.ZoneRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

@SpringBootApplication
@Controller
public class ApplicationController {

    public static List<String> connectedZones = new ArrayList<>();

    public static final Logger logger = LoggerFactory.getLogger(ApplicationController.class);
    @Autowired
    private GymRepository gymRepository;

    @Autowired
    private TemplateRepository templateRepository;

    @Autowired
    private ZoneRepository zoneRepository;

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    //    template object
    Templates currentTemplate ;

//    Zone object
    Zones currentZone;

    @RequestMapping("/")
    public String index(HttpServletRequest request){
        if(validUser(request)!=null){
            return "redirect:/adminDashboard";
        }
        else
        return "home";
    }

//    Admin Login Page
    @RequestMapping("/adminLogin")
    public String adminLogin(){
        return "home";
    }

    @RequestMapping("/video")
    public String video(){
        return "video";
    }


    @PostMapping("/adminLogin")
    public String checkAdmin(Gym gym , Model model,HttpServletRequest request) {
        Gym admin = gymRepository.findByGymId(gym.getGymId());
        if(admin!=null && admin.getPassword().equals(gym.getPassword())){
//            setting session attribute - gymId
            logger.info("Login Successful");
            request.getSession().setAttribute("gymId" , admin.getGymId() );

//            Redirecting to /adminDashboard
            return "redirect:/adminDashboard";
        }
        else{
            logger.info("Login Failed");
            return "redirect:/";
        }
    }

//    Display all templates - adminDashboard
    @RequestMapping("/adminDashboard")
    public String adminDashboard(HttpServletRequest request , Model model){
        if(validUser(request)!=null){
            //      Retrieve Template
            List<Templates> templateList = getTemplates();
            Templates temporaryObject=null;
            logger.info("List of all templates to be passed : " + templateList);
            for(Templates templateObject: templateList) {
            	//getting the exerciseCount and the exerciseDuration and setting inside template List
            	temporaryObject=getExcerciseCountAndExerciseDuration(templateObject);
            	templateObject.setExerciseCount(temporaryObject.getExerciseCount());
            	templateObject.setExerciseDuration(temporaryObject.getExerciseDuration());
            	logger.info("templateObject"+templateObject.getExerciseCount());
            }
            model.addAttribute("templateList" , templateList);
            
            return "adminDashboard";
        }
        return "redirect:/";
    }



//    Create Template
    @PostMapping("/adminDashboard")
    public String addTemplate(Templates template){
    	logger.info("templateLogo"+template.getTemplateLogo());
    	templateRepository.save(template);
        logger.info("Template "+ template.getTemplateName() +" - saved successfully ");
        return "redirect:/adminDashboard";
    }

//    Zone Add exercise dashboard
    @RequestMapping("/templateDashboard/{templateId}")
    public String templateDashboard(@PathVariable("templateId") Long templateId , Model model,HttpServletRequest request){

            if(validUser(request)!=null){
                try{
                    currentTemplate = getTemplateById(templateId);
                    logger.info("Selected template Name = "+currentTemplate.getTemplateName());
                    model.addAttribute("template" , currentTemplate);
                    List<Templates> templateList = getTemplates();
                    logger.info("List of all templates to be passed : " + templateList);
                    model.addAttribute("templateList" , templateList);
//                    getting zoneId from request query string ; if null zone1 is made active (default)
                    String zoneId= getZoneId(request);
                    logger.info("Active zone ID - " + zoneId);
                    model.addAttribute("zoneId" , zoneId);
//                    checking if exercise present for current zone
//                    Boolean isZonePresent = true ;
                    Boolean isZonePresent = zoneRepository.existsZonesByTemplateIdAndZone(currentTemplate ,zoneId) ;
                    logger.info(zoneId+" found for Template : " + isZonePresent);
                    model.addAttribute("isZonePresent",isZonePresent);
//                    If exercise added for current zone - fetching the exercise details to display
                    if(isZonePresent){
                        Zones zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate,zoneId);
                        model.addAttribute("zoneDetails" , zoneDetails);
//                        Fetching Saved exercise Details List
                        List<Exercise> exerciseList = zoneDetails.getExerciseDetails();
                        model.addAttribute("exerciseList" , exerciseList);
                    }
                    //        Checking if is any template session started and getting details
                    model = checkAndGetActiveTemplateDetails(model);
                    return "templateDashboard";
                }catch (Exception e){
                    logger.error("Exception Caught at /templateDashboard :: " + e);
                }
            }
            return "redirect:/invalidUser";
    }

//    Saving the Template Time config
    @PostMapping("/templateDashboard/{templateId}/{zoneId}")
    public String saveTemplateTimeConfig(@PathVariable("templateId") Long templateId ,@PathVariable("zoneId") String zone ,@RequestParam(value = "exerciseMins") int exerciseMins ,
                                         @RequestParam(value = "exerciseSecs") int exerciseSecs , @RequestParam(value = "repsCount") int repsCount ,
                                         @RequestParam(value = "breakMins") int breakMins , @RequestParam(value = "breakSecs") int breakSecs)
    {
        try{
            exerciseSecs += (exerciseMins*60);
            breakSecs += (breakMins*60);
            currentTemplate = getTemplateById(templateId);
            if(currentTemplate!=null){
                Zones zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate , zone);
                zoneDetails.setSeconds(exerciseSecs);
                zoneDetails.setReps(repsCount);
                zoneDetails.setBreakTime(breakSecs);
                logger.info("----- Saving template time Configuration --- Seconds - " +exerciseSecs + " ; Reps - " +repsCount+ " ; BreakTime - " + breakSecs);
                zoneRepository.save(zoneDetails);
            }
        }
        catch(Exception ex){
            logger.error("Exception while saving template time Configuration :: " + ex);
        }
        return  "redirect:/templateDashboard/"+templateId+"?zoneId="+zone;
    }

//    Select Exercise Dashboard
    @RequestMapping("/selectExercise/{templateId}")
    public String selectExercise(@PathVariable Long templateId , HttpServletRequest request , Model model){
        if(validUser(request)!=null) {
            try{
                String zoneId= getZoneId(request);
                model.addAttribute("zoneId" , zoneId);
                logger.info("Active zone ID - " + zoneId);
                currentTemplate = getTemplateById(templateId);
                if(currentTemplate!=null){
                    logger.info("Current TemplateID - " + currentTemplate.getTemplateId());
                    model.addAttribute("template" , currentTemplate);
                    List<Exercise> exerciseList = getSavedExercisesForZone(currentTemplate , zoneId);
//                    logger.info("size"+exerciseList.size());
                    model.addAttribute("exerciseList" , exerciseList) ;
                    logger.info("ExerciseList Size : " + exerciseList.size());
                    if(exerciseList.size()<=0){
                        logger.warn("** exerciseList sending as EMPTY **");
                        model.addAttribute("exerciseArray","empty");
                    }else {
                    	String exerciseListString="";
                    	int i=0;
                    	for(Exercise exercise:exerciseList) {
                    		exerciseListString+="<li class=\"card sortable-card white-text row\" id=\""+exercise.getId()+"\" ><span style=\"margin-left: -10px\" class=\"mt-2\"><a onclick=\"removeSelectedExcercise('"+exercise.getId()+"')\"><img src=\"../../img/exerciseMinus.svg\" class=\"img-fluid mt-3\"></a>"
                    	     			+"</span><span class=\"mt-3\" ><p >"+exercise.getExerciseName()+"</p></span><span class=\"row mt-2\" style=\"position: absolute;margin-left: 90px;\"><p class=\"sortable-blur-text mr-4\" style=''>"+i+"</p></span></li>";
                    	}
                    	ObjectMapper mapper = new ObjectMapper();
                    	logger.info(mapper.writeValueAsString(exerciseList));
                    	model.addAttribute("exerciseListString",exerciseListString);
                    	model.addAttribute("exerciseArray",mapper.writeValueAsString(exerciseList));
                    }
                }
                else{
                    logger.warn("Current Template Object is null - check");
                }
    //            if(zoneRepository.existsZonesByTemplateIdAndZone())
                return "selectExercise";
            }catch(Exception ex){
                logger.warn("Exception Caught :: " + ex);
            }
        }
        return "redirect:/invalidUser";
    }
    
    /*method to change the category name in file path and return fileList based on the filePath*/
    @PostMapping("/selectExerciseAjax")
    public @ResponseBody String[] selectExerciseAjax(@RequestParam(value="category") String category) throws IOException{
    	File directory = new File(System.getProperty("user.dir")+"/src/main/webapp/exercises/"+category.toLowerCase()+"/");
    	logger.info("path : "+ directory.toString());
         String[] fileList = directory.list();
         for(String name : fileList) {
        	 logger.info("FileName : " + name);
         }
	return fileList;
    }

    /*method to save the selectedExerciseArray using ajax */
    @PostMapping("/saveSelectedExerciseAjax")
    public @ResponseBody String saveSelectExerciseAjax(@RequestParam(value="selectedExcerciseArray") String saveSelectedExcerciseArray, @RequestParam(value="templateId") Long templateId , @RequestParam(value = "zoneId") String zone ) throws IOException{
    	logger.info("---------  Selected exerciseArray - " + saveSelectedExcerciseArray + "------------");
    	currentTemplate = getTemplateById(templateId);
    	logger.info("currentTemplate Id - " + currentTemplate.getTemplateId() + " Current Zone - "+ zone);
    	ObjectMapper mapper = new ObjectMapper();
        try {
            List<Exercise> selectedExerciseList = Arrays.asList(mapper.readValue(saveSelectedExcerciseArray, Exercise[].class));
            logger.info("------======Exercise Map to DATABASE :: " + selectedExerciseList +" =======------");
            Zones zoneDetails ;
//            Saving Exercise in Database
//            Update
            if(zoneRepository.existsZonesByTemplateIdAndZone(currentTemplate , zone)){
                zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate , zone);
                zoneDetails.setExerciseDetails(selectedExerciseList);
            }
//            create
            else{
                zoneDetails = new Zones();
                zoneDetails.setTemplateId(currentTemplate);
                zoneDetails.setZone(zone);
                zoneDetails.setExerciseDetails(selectedExerciseList);
                zoneRepository.save(zoneDetails);
            }
        } catch (Exception e) {
            logger.error("Exception Occurred while saving selected exercise to database");
            e.printStackTrace();
        }
        return "success";
    }

//    ----------------========   CLIENT SIDE CONTROLLERS  =======-------------------------

//    home to connect - displays zones
    @RequestMapping("/connect")
    public String connectHome(Model model){
//        Checking if is any template session started and getting details
        model = checkAndGetActiveTemplateDetails(model);
        return "connect";
    }

    //    When Admin start Section
    //    Mapped when admin starts session
    @RequestMapping("/adminCommand/{templateId}/{command}")
    public String startSection(@PathVariable Long templateId , @PathVariable String command,HttpServletRequest request){
        SocketMessage adminCommand = new SocketMessage();
        logger.info("Getting templateId " + templateId);
        logger.info("--------------------:: RECEIVED COMMAND - " + command + ":: --------------------");
        adminCommand.setCommand(command);
        adminCommand.setTemplateId(templateId);
        for(String client : connectedZones){
            messagingTemplate.convertAndSend("/zone/client."+client , adminCommand);
        }
        String zoneId= getZoneId(request);
        logger.info("Active zone ID - " + zoneId);

//        To update active column in database
        switch (command){
            case "start" : {
                Templates templateToUpdate = templateRepository.findTemplatesByTemplateId(templateId);
                templateToUpdate.setActive(1);
                break;
            }
            case "pause" :
            case "stop" : {
                Templates templateToUpdate = templateRepository.findTemplatesByTemplateId(templateId);
                templateToUpdate.setActive(0);
                break;
            }
        }

        return "redirect:/templateDashboard/"+templateId+"?zoneId="+zoneId;
    }

//    FETCH Exercise to Display AJAX
    @PostMapping("/fetchExerciseDetailsToDisplay")
    public String fetchExerciseDetailsToDisplay(@RequestParam(value = "zone") String zone , @RequestParam(value = "templateId") Long templateId){
        logger.info("--------------Ajax controller called -- zone :: " +zone + " ; templateId :: " +templateId+" --------------");
        Display display = new Display();
        ObjectMapper mapper = new ObjectMapper();
        String exerciseDetails = "";
        try{
            currentTemplate = templateRepository.findTemplatesByTemplateId(templateId);
            if(zoneRepository.existsZonesByTemplateIdAndZone(currentTemplate,zone)){
                currentZone = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate , zone);
                display.setTemplates(currentTemplate);
                display.setZones(currentZone);
                exerciseDetails = mapper.writeValueAsString(display);
            }

        }
        catch(Exception ex){
            logger.error("Exception occurred while DISPLAY EXERCISE AJAX CONTROLLER processing :: " + ex);
        }
        return exerciseDetails;
    }

//    -----------------


//   ERROR
    @RequestMapping("/invalidUser")
    public String error(){
        return "error";
    }

//    ------------------  UTILITIES  ---------------------------

//    Retrieve zoneId from request and add model Attribute
    public String getZoneId(HttpServletRequest request){
        //            getting zoneId from request
        String zoneId =  request.getParameter("zoneId");
        logger.info("Received zone ID - " + zoneId);
        if(zoneId==null){
            zoneId = "zone1";
            logger.info("Zone Id is null , so adding default zone 1");
        }
        return zoneId;
    }

    //    Authentication check
    public String  validUser(HttpServletRequest request){
        if(request.getSession().getAttribute("gymId")!=null){
            return request.getSession().getAttribute("gymId").toString();
        }
        return null;
    }

//    get Template with templateId
    public Templates getTemplateById(Long templateId){
        Templates currentTemplate = templateRepository.findTemplatesByTemplateId(templateId);
        return currentTemplate;
    }

//    Checking Template is active and fetching details - add model attribute
    public Model checkAndGetActiveTemplateDetails(Model model){
        //  Checking ant template is started/active
        Boolean isTemplateActive = templateRepository.existsTemplatesByActive(1);
        model.addAttribute("isTemplateActive" , isTemplateActive);
        logger.info("isTemplateActive : " + isTemplateActive );
        //  If template is started fetching its details
        if(isTemplateActive){
            Templates activeTemplate = templateRepository.findTemplatesByActive(1);
            model.addAttribute("activeTemplate" , activeTemplate);
        }
        return  model;
    }

    //    get All templates
    public  List<Templates> getTemplates(){
        List<Templates> templateList = (List<Templates>) templateRepository.findAll();
        return templateList;
    }
    //adding all saved Exercises and their Respective time duration
    private Templates getExcerciseCountAndExerciseDuration(Templates currenTemplate) {
    	ResourceBundle resource = ResourceBundle.getBundle("application-settings");
    	int exerciseCount = 0;
    	int exerciseTimeDuration = 0;
        String zoneCount = resource.getString("zone.count");
    	Zones zoneDetails=null;
    	logger.info("templateId"+currenTemplate.getTemplateId());
    	for(int zone=1;zone<Integer.parseInt(zoneCount);zone++) {
    		logger.info("templateId"+currenTemplate.getTemplateId());
    		if(zoneRepository.existsZonesByTemplateIdAndZone(currenTemplate,"zone"+zone)){
    			logger.info("zoneId"+zone);
	    		zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currenTemplate,"zone"+zone);
	    		exerciseCount+=zoneDetails.getExerciseDetails().size();
	    		exerciseTimeDuration +=zoneDetails.getSeconds();
	    		logger.info("ExerciseCount"+exerciseCount);
    		}
    	}
    	
    	Templates tempObject = new Templates();
    	tempObject.setExerciseCount(exerciseCount);
    	tempObject.setExerciseDuration(exerciseTimeDuration);
    	return tempObject;
    }

//    Get saved exercise for template - zone :: zoneDetails
    public List<Exercise> getSavedExercisesForZone(Templates currentTemplate , String zone ){
            List<Exercise> exerciseList = new ArrayList<>();
            logger.info("--- TemplateId :: " + currentTemplate.getTemplateId() +" ; zone ::"+ zone + "---");
            try{
                Zones zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate,zone);
                if(zoneDetails!=null){
                    exerciseList = zoneDetails.getExerciseDetails();
                    logger.info("Length of ZoneDetails exerciseList  : " + exerciseList.size());
                    logger.info("------Exercise List :: " + exerciseList +" -------");
//                    for(Exercise ex : exerciseList){
//                        logger.info(ex.getExerciseName() +" "+ex.getUrl());
//                    }
                }
            }
            catch(Exception e){
                logger.warn("Exception occurred while get zone Details - getSavedExercisesForZone() :: " + e);
            }
            return exerciseList;
    }

}
