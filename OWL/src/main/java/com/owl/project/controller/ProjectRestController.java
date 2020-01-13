package com.owl.project.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.owl.project.dto.ProjectList;
import com.owl.project.service.ProjectService;

@RestController
public class ProjectRestController {

	@Autowired
	private ProjectService service;
	
	
	@RequestMapping(value="EditMyProject.do")
	public  boolean updateProjectList(ProjectList projectlist, Principal principal, HttpServletRequest request, Model model) {
		
		boolean result = false;
		try {
			projectlist.setEmail(principal.getName());
			projectlist.setFavorite(projectlist.getFavorite());
			projectlist.setProjectColor(projectlist.getProjectColor());
			result = service.updateProjectList(projectlist);						

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
}