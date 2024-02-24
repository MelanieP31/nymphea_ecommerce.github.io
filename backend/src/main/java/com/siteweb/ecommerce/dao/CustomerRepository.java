package com.siteweb.ecommerce.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.siteweb.ecommerce.entity.Customer;

//L'interface pour customer (il a une collection de produits)
public interface CustomerRepository extends JpaRepository<Customer, Long> {
	Customer findByEmail(String theEmail);
}
