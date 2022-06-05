package com.emiliodevesa.kot.core;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IssueService {
    @Autowired private IssueRepository issueRepository;

    public List<Issue> listAll(){
        return (List<Issue>) issueRepository.findAll();
    }

    public void save(Issue issue){
        issueRepository.save(issue);
    }

}
