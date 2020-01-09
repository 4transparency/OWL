package com.owl.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.owl.member.dto.Member;
import com.owl.member.service.MemberService;

@RestController
public class MemberRestController {
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private VelocityEngineFactoryBean velocityEngineFactoryBean;

	@Autowired
	private MemberService service;	
	
	@RequestMapping(value = "ForgotPassword.do")
	public Map<String, Object> findPassword(String email) throws Exception {
		System.out.println("in FindPassword");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isMember = false;
		String message = "";
		isMember = true;
		email="dbsekwjdaa@naver.com";
		// 회원 경우
		if (isMember) {
			isMember = true;
			try {
				MimeMessage content = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(content, true, "UTF-8");
				Map<String, Object> models = new HashMap<String, Object>();

				String mailBody = VelocityEngineUtils.mergeTemplateIntoString(
						velocityEngineFactoryBean.createVelocityEngine(), "forgotPasswordTemplate.vm", "UTF-8", models);
				messageHelper.setSubject("[OWL] 비밀번호 재설정");
				messageHelper.setFrom("bit_team2@naver.com");
				messageHelper.setTo(email);
				messageHelper.setText(mailBody, true);
				mailSender.send(content);

			} catch (Exception e) {
				System.out.println("이거 에러..>" + e.getMessage());
			}
			message = "이메일을 전송했습니다." + "\n이메일을 확인해주세요.";
		}
		// 비회원 경우
		else {
			message = "존재하지 않는 이메일입니다.";
		}

		map.put("result", isMember);
		map.put("message", message);

		return map;
	}
	
	/*
	 * @RequestMapping(value="GetMember.do") public String GetMember(String email){
	 * 
	 * Member member = service.getMember("qqq@gmail.com");
	 * 
	 * return member; }
	 */

	//회원정보 조회 (test)
	@RequestMapping("/GetMember.do")
	public String GetMember(String email, Model model) throws Exception{
	try {	
		//회원정보
		Member member = service.getMember("qqq@gmail.com");
		System.out.println("멤버 조회 : " + member);
		model.addAttribute("member", member);
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}

	return "include/modal/myProfileSetting";
	}
	
}
