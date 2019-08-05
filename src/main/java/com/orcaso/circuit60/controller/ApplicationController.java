package com.orcaso.circuit60.controller;

import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.SocketMessage;
import com.orcaso.circuit60.model.Templates;
import com.orcaso.circuit60.model.Zones;
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
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@SpringBootApplication
@Controller
public class ApplicationController {

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

    @RequestMapping("/")
    public String index(HttpServletRequest request){
        if(validUser(request)!=null){
            return "redirect:/adminDashboard";
        }
        else
        return "home";
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
            logger.info("List of all templates to be passed : " + templateList);
            model.addAttribute("templateList" , templateList);
            return "adminDashboard";
        }
        return "redirect:/";
    }

//    Create Template
    @PostMapping("/adminDashboard")
    public String addTemplate(Templates template){
        templateRepository.save(template);
        logger.info("Template "+ template.getTemplateName() +" - saved successfully ");
        return "redirect:/adminDashboard";
    }

//    Zone Add exercise dashboard
    @RequestMapping("/templateDashboard/{templateId}")
    public String templateDashboard(@PathVariable("templateId") Long templateId , Model model,HttpServletRequest request){

            if(validUser(request)!=null){
                try{
                    Templates template = templateRepository.findTemplatesByTemplateId(templateId);
                    currentTemplate = template;
                    logger.info("Selected template Name = "+template.getTemplateName());
                    model.addAttribute("template" , template);
                    List<Templates> templateList = getTemplates();
                    logger.info("List of all templates to be passed : " + templateList);
                    model.addAttribute("templateList" , templateList);
                    String zoneId= getZoneId(request);
                    logger.info("Active zone ID - " + zoneId);
                    model.addAttribute("zoneId" , zoneId);
                    Boolean isZonePresent = true ;
//                    Boolean isZonePresent = zoneRepository.existsZonesByTemplateIdAndZone(currentTemplate ,zoneId) ;
                    logger.info(zoneId+" found for Template : " + isZonePresent);
                    model.addAttribute("isZonePresent",isZonePresent);
                    if(isZonePresent){
                        Zones zoneDetails = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate,zoneId);
                        model.addAttribute("zoneDetails" , zoneDetails);
                    }
                    return "templateDashboard";
                }catch (Exception e){
                    logger.warn("Exception Caught :: " + e);
                }
            }
            return "redirect:/invalidUser";
    }

//    Select Exercise Dashboard
    @RequestMapping("/selectExercise")
    public String selectExercise(HttpServletRequest request , Model model){
        if(validUser(request)!=null) {
            try{
            String zoneId= getZoneId(request);
            model.addAttribute("zoneId" , zoneId);
            logger.info("Active zone ID - " + zoneId);
            if(currentTemplate!=null){
                model.addAttribute("template" , currentTemplate);
            }
            else{
                logger.warn("Current Template Object is null - check");
            }
            model.addAttribute("template" , currentTemplate);
//            if(zoneRepository.existsZonesByTemplateIdAndZone())
            return "selectExercise";
            }catch(Exception ex){
                logger.warn("Exception Caught :: " + ex);
            }
        }
        return "redirect:/invalidUser";
    }

//    CLIENT SIDE CONTROLLERS
//    home to connect - displays zones
    @RequestMapping("/connect")
    public String connectHome(){
        return "connect";
    }

    //    When Admin start Section
    //    Mapped when admin starts session
    @RequestMapping("/startSection/{templateId}")
    public String startSection(@PathVariable Long templateId , HttpServletRequest request ,Model model){
        SocketMessage adminCommand = new SocketMessage();
        logger.info("working" + templateId);
        adminCommand.setCommand("start");
        adminCommand.setTemplateId(templateId);
        messagingTemplate.convertAndSend("/zone/client" , adminCommand);
        String zoneId= getZoneId(request);
        logger.info("Active zone ID - " + zoneId);
        Templates templateToUpdate = templateRepository.findTemplatesByTemplateId(templateId);
        templateToUpdate.setActive(1);
        return "redirect:/templateDashboard/"+templateId+"?zoneId="+zoneId;
    }

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

    //    get All templates
    public  List<Templates> getTemplates(){
        List<Templates> templateList = (List<Templates>) templateRepository.findAll();
        return templateList;
    }

}
