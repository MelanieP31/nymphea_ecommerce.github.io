package com.siteweb.ecommerce.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.siteweb.ecommerce.entity.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Long>{

}
