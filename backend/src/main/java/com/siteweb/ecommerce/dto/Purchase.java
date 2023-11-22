package com.siteweb.ecommerce.dto;

import java.util.Set;

import com.siteweb.ecommerce.entity.Address;
import com.siteweb.ecommerce.entity.Customer;
import com.siteweb.ecommerce.entity.Order;
import com.siteweb.ecommerce.entity.OrderItem;

import lombok.Data;

@Data
public class Purchase {

    private Customer customer;
    private Address shippingAddress;
    private Address billingAddress;
    private Order order;
    private Set<OrderItem> orderItems;

}
