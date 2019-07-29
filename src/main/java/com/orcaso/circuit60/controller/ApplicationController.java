package com.orcaso.circuit60.controller;
import com.orcaso.circuit60.dao.impl.GymDAOImpl;
import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.Templates;
import com.orcaso.circuit60.repository.GymRepository;
import com.orcaso.circuit60.repository.TemplateRepository;
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

    @Autowired
    private GymRepository gymRepository;

    @Autowired
    private TemplateRepository templateRepository;
    Templates templateObj;

    @RequestMapping("/")
    public String index(){
        return "home";
    }


    @PostMapping("/adminLogin")
    public String checkAdmin(Gym gym , Model model,HttpServletRequest request) {
//    public String checkAdmin(HttpServletRequest request) {
        Gym admin = gymRepository.findByGymId(gym.getGymId());
        if(admin!=null && admin.getPassword().equals(gym.getPassword())){
            request.getSession().setAttribute("gymId" , admin.getGymId() );
//            Retrieve Template
            List<Templates> templates = templateRepository.findAllByGymId(admin);
            System.out.println("templateList : " +templates);
            model.addAttribute("templateList" , templates);
            return "adminDashboard";
//            return "redirect:/";
        }
        else{
            System.out.println("Failure");
            return "redirect:/";
        }
//        return "template" ;
    }

    @RequestMapping("/adminDashboard")
    public String dashboard(){

        return "adminDashboard";
    }

//    Create Template
    @PostMapping("/adminDashboard")
    public String addTemplate(Templates template,Model model){
        System.out.println("GymId= " + template.getGymId());
        templateRepository.save(template);
        System.out.println("save successfull");
        //            Retrieve Template
        List<Templates> templates = templateRepository.findAllByGymId(template.getGymId());
        System.out.println("templateList : " +templates);
        model.addAttribute("templateList" , templates);
        return "adminDashboard";
    }

//    Zone Add exercise dashboard
    @RequestMapping("/templateDashboard/{templateName}")
    public String templateDashboard(@PathVariable("templateName") String templateName , Model model,HttpServletRequest request){
        if(request.getSession().getAttribute("gymId")!=null){
            System.out.println("Selected template Name = "+templateName);
            model.addAttribute("templateName" , templateName);
            Gym gym = new Gym();
            gym.setGymId(request.getSession().getAttribute("gymId").toString());
            List<Templates> templates = templateRepository.findTemplatesByGymId(gym);
            System.out.println("Templates Fetched with gymId " + templates);
            model.addAttribute("templateList" , templates);
            return "templateDashboard";
        }
        return "redirect:/invalidUser";
    }

//    Select Exercise Dashboard
    @RequestMapping("/selectExcercise")
    public String selectExcercise(){
        return "selectExercise";
    }

//   ERROR
    @RequestMapping("/invalidUser")
    public String error(){
        return "error";
    }

}
