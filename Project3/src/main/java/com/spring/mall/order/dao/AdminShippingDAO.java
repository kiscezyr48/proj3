package com.spring.mall.order.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.mall.order.vo.UserOrderVO;

@Repository
public class AdminShippingDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public AdminShippingDAO() {
		System.out.println(">> AdminShippingDAO() 객체 생성 ");
	}
	
	//1. 관리자 상품 주문 테이블 목록 불러오기
	public List<UserOrderVO> getOrderList(UserOrderVO vo) {
		return mybatis.selectList("adminShippingDAO.getOrderList", vo);
	}
	
	//2. 관리자 주문 상태 변경 
	public void updateOrderState(String order_id) {
		mybatis.update("adminShippingDAO.updateOrderState", order_id);
	}
	
}
