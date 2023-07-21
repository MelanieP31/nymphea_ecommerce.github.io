package com.formation.ecommerce.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.formation.ecommerce.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{
}
