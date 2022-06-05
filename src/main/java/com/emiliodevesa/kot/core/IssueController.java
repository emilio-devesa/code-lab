package com.emiliodevesa.kot.core;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class IssueController {
    @Autowired private IssueService issueService;

    @GetMapping("/issue/list")
    public String showIssueList(Model model){
        List<Issue> issueList=issueService.listAll();
        model.addAttribute("issueList", issueList);
        return "issueList";
    }

    @GetMapping("/issue/new")
    public String newIssue(Model model){
        model.addAttribute("issue", new Issue());
        return "newIssue";
    }

    @PostMapping("/issue/save")
    public String saveIssue(Issue issue, RedirectAttributes redirectAttributes){
        issueService.save(issue);
        redirectAttributes.addFlashAttribute("message", "The Issue has been saved successfully");
        return "redirect:/issue/list";
    }


}
