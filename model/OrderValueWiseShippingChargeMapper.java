package eStoreProduct.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class OrderValueWiseShippingChargeMapper implements RowMapper<OrderValueWiseShippingCharge> {

    @Override
    public OrderValueWiseShippingCharge mapRow(ResultSet rs, int rowNum) throws SQLException {
	OrderValueWiseShippingCharge os=new OrderValueWiseShippingCharge(
		rs.getInt("ordvl_id"),
		rs.getDouble("ordrvl_from"),
		rs.getDouble("ordrvl_to"),
		rs.getDouble("ordrvl_shippingamount")
		);
	return os;
    }

}
