package com.orcaso.circuit60.controller;

import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.Templates;
import com.orcaso.circuit60.repository.GymRepository;
import com.orcaso.circuit60.repository.TemplateRepository;
import com.orcaso.circuit60.repository.ZoneRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
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

    Logger logger = LoggerFactory.getLogger(ApplicationController.class);
    @Autowired
    private GymRepository gymRepository;

    @Autowired
    private TemplateRepository templateRepository;

    @Autowired
    private ZoneRepository zoneRepository;


    //    Get Gym Object
    public Gym getGym(HttpServletRequest request){
        Gym gym = new Gym();
        gym.setGymId(request.getSession().getAttribute("gymId").toString());
        return gym;
    }

    //    Authentication check
    public String  validUser(HttpServletRequest request){
        if(request.getSession().getAttribute("gymId")!=null){
            return request.getSession().getAttribute("gymId").toString();
        }
        return null;
    }
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
            logger.info("Login Successfull");
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
            List<Templates> templates = templateRepository.findAllByGymId(getGym(request));
            logger.info("templateList of current user - " +templates);
            model.addAttribute("templateList" , templates);
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
    @RequestMapping("/templateDashboard/{templateName}")
    public String templateDashboard(@PathVariable("templateName") String templateName , Model model,HttpServletRequest request){
        if(validUser(request)!=null){
            System.out.println("Selected template Name = "+templateName);
            model.addAttribute("templateName" , templateName);
            List<Templates> templates = templateRepository.findTemplatesByGymId(getGym(request));
            System.out.println("Templates Fetched with gymId " + templates);
            model.addAttribute("templateList" , templates);
            model = addZoneId(request, model);
            return "templateDashboard";
        }
        return "redirect:/invalidUser";
    }

//    Select Exercise Dashboard
    @RequestMapping("/selectExercise")
    public String selectExcercise(HttpServletRequest request , Model model){
        if(validUser(request)!=null) {
            model = addZoneId(request, model);
//            if(zoneRepository.existsZonesByTemplateIdAndZone())
            return "selectExercise";
        }
        return "redirect:/invalidUser";
    }

//   ERROR
    @RequestMapping("/invalidUser")
    public String error(){
        return "error";
    }

//    Retrieve zoneId from request and add model Attribute
    public Model addZoneId(HttpServletRequest request , Model model){
        //            getting zoneId from request
        String zoneId =  request.getParameter("zoneId");
        logger.info("Received zone ID - " + zoneId);
        if(zoneId==null){
            zoneId = "zone1";
            logger.info("Zone Id is null , so adding default zone 1");
        }
        model.addAttribute("zoneId" , zoneId);
        logger.info("Active zone ID - " + zoneId);
        return model;
    }


}
