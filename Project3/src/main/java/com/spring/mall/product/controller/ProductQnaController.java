package com.spring.mall.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.mall.product.service.ProductQnaService;
import com.spring.mall.product.service.ProductService;
import com.spring.mall.product.vo.ProductQnaNickVO;
import com.spring.mall.product.vo.ProductQnaVO;
import com.spring.mall.product.vo.ProductVO;

@Controller
@RequestMapping("/productQna/**")
public class ProductQnaController {
	
	@Autowired
	private ProductQnaService productQnaService;
	@Autowired
	private ProductService productService;
	
	public ProductQnaController() {
		System.out.println("ProductQnaController() 객체 생성");
	}
	
	// 상품문의 답변 제출
	@RequestMapping("/SubmitAdminProductQna.do")
	public String submitAdminProductQna(ProductQnaNickVO vo, HttpServletRequest request) {
		System.out.println("submitAdminProductQna() 실행");
		ProductQnaNickVO productQna = productQnaService.getProductQnaNick(vo);
		System.out.println("vo : " + vo);
		System.out.println("productQna : " + productQna);
		
		// 답변 입력
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		String qna_content = productQna.getQna_content();
		String product_id = Integer.toString(productQna.getProduct_id());
		String qna_group = Integer.toString(productQna.getQna_group());
		productQnaService.insertAdminProductQna(qna_content, product_id, user_id, qna_group);
		
		// 문의 상태 변경
		productQnaService.updateProductQnaState(vo);
		
		return "forward:/adminProductQnaList.do";
	}
	
	
	@RequestMapping("/insertPrdQna.do")
	public String insertProductQna(ProductQnaVO vo ,ProductVO pvo,HttpSession session,
									RedirectAttributes rdatt) {
		String user_id = (String) session.getAttribute("user_id");
		vo.setUser_id(user_id);
		System.out.println("vo : " + vo);
		
		productQnaService.insertProductQna(vo);
		rdatt.addAttribute("product_id",pvo.getProduct_id());
		
		return "forward:/tempPrd.do";
	}
	
	
	// 페이지 테스트-- 삭제 예정-------------------------------
	@RequestMapping("/viewMypage.do")
	public String viewMyPage() {
		
		return "user/myPageTemplate";
	}
	

	
	
}
