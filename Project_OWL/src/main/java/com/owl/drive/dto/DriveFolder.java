package com.owl.drive.dto;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DriveFolder {
	private int driveIdx; //폴더식별번호
	private int projectIdx;
	private String folderName;
	private int ref;
	private int depth;
	private CommonsMultipartFile multipartFile;
}