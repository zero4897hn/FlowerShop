package com.example.zero.entity;

import java.util.List;

import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;

public class MSWordWriter {
	private XWPFDocument document;
	
	public MSWordWriter() {
		document = new XWPFDocument();
	}
	
	public void writeAParagraph(String text) {
		XWPFParagraph paragraph = document.createParagraph();
		paragraph.setFirstLineIndent(400);
		paragraph.setAlignment(ParagraphAlignment.BOTH);
		paragraph.setWordWrapped(true);
		XWPFRun run = paragraph.createRun();
		run.setText(text);
		run.setFontSize(13);
		run.setFontFamily("Times New Roman");
	}
	
	public void writeATitle(String text) {
		XWPFParagraph paragraph = document.createParagraph();
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		paragraph.setWordWrapped(true);
		XWPFRun run = paragraph.createRun();
		run.setText(text);
		run.setFontSize(20);
		run.setFontFamily("Times New Roman");
		run.setBold(true);
	}
	
	public void createTable(String[] titles, List<String[]> bodies) {
		XWPFTable table = document.createTable();
		XWPFTableRow rowHeader = table.getRow(0);
		
		XWPFTableCell cellHeader0 = rowHeader.getCell(0);
		XWPFParagraph paragraphHeader0 = cellHeader0.getParagraphArray(0);
		paragraphHeader0.setAlignment(ParagraphAlignment.CENTER);
		paragraphHeader0.setWordWrapped(true);
		XWPFRun runHeader0 = paragraphHeader0.createRun();
		runHeader0.setText(titles[0]);
		runHeader0.setFontSize(13);
		runHeader0.setFontFamily("Times New Roman");
		runHeader0.setBold(true);
		
		for (int i = 1; i < titles.length; i++) {
			XWPFTableCell cellHeader = rowHeader.addNewTableCell();
			XWPFParagraph paragraphHeader = cellHeader.getParagraphArray(0);
			paragraphHeader.setAlignment(ParagraphAlignment.CENTER);
			paragraphHeader.setWordWrapped(true);
			XWPFRun runHeader = paragraphHeader.createRun();
			runHeader.setText(titles[i]);
			runHeader.setFontSize(13);
			runHeader.setFontFamily("Times New Roman");
			runHeader.setBold(true);
		}
		
		for (String[] body : bodies) {
			XWPFTableRow row = table.createRow();
			for (int i = 0; i < body.length; i++) {
				XWPFTableCell cell = row.getCell(i);
				XWPFParagraph paragraphHeader = cell.getParagraphArray(0);
				XWPFRun runHeader = paragraphHeader.createRun();
				if (body[i].charAt(0) == '*') {
					paragraphHeader.setAlignment(ParagraphAlignment.CENTER);
					runHeader.setText(body[i].substring(1));
				}
				else {
					paragraphHeader.setAlignment(ParagraphAlignment.BOTH);
					runHeader.setText(body[i]);
				}
				paragraphHeader.setWordWrapped(true);
				runHeader.setFontSize(13);
				runHeader.setFontFamily("Times New Roman");
			}
		}
	}
	
	public void writeAParagraph(String text, ParagraphAlignment alignment) {
		XWPFParagraph paragraph = document.createParagraph();
		paragraph.setAlignment(alignment);
		paragraph.setWordWrapped(true);
		XWPFRun run = paragraph.createRun();
		run.setText(text);
		run.setFontSize(13);
		run.setFontFamily("Times New Roman");
	}
	
	public XWPFDocument getDocument() {
		return document;
	}
}
