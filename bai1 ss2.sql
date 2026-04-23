-- Lỗi logic: Mặc dù DECIMAL là kiểu dữ liệu chính xác, 
--    nhưng vấn đề thường nằm ở cách ngôn ngữ lập trình (như JavaScript/C++) 
--    xử lý số thực trước khi đưa vào SQL, hoặc cách bạn tính toán thuế/chiết khấu.

-- Thực tế tại Việt Nam: Đơn vị tiền tệ là VNĐ, không có phần thập phân 
--    (xu/hào không còn dùng). Việc để DECIMAL(18, 2) vô tình cho phép các phép tính 
--    (ví dụ: giảm giá 15%) tạo ra các số lẻ như 100.55. Khi cộng dồn hàng triệu đơn hàng, 
--    những con số "vài đồng lẻ" này sẽ gây lệch báo cáo kế toán.

-- Cột ProductName VARCHAR(255): Dù tên sản phẩm ngắn, 
--    VARCHAR chỉ tốn dung lượng thực tế của chuỗi + 1-2 bytes độ dài. 
--    Tuy nhiên, nếu hệ thống có hàng triệu sản phẩm và các index trên cột 
--    này quá lớn, nó sẽ chiếm bộ nhớ đệm (RAM) rất nhanh.

-- Cột Description TEXT: Đây là "thủ phạm" chính. Kiểu TEXT thường được lưu 
--    trữ ngoài bảng (off-page storage). Việc truy vấn các bảng có cột TEXT mà 
--    không cần thiết sẽ khiến SQL Server/MySQL tốn nhiều công sức để quản lý con 
--    trỏ bộ nhớ, dẫn đến báo đầy bộ nhớ ảo hoặc RAM rất nhanh.

-- Cột ID INT: Nếu đây là hệ thống thương mại điện tử lớn, INT (tối đa ~2 tỷ record) 
--    có thể là chưa đủ trong tương lai dài hạn, nhưng lỗi "đầy bộ nhớ nhanh" thường 
--    do các cột dữ liệu lớn (LOB) gây ra.


CREATE TABLE PRODUCTS (
    ID BIGINT PRIMARY KEY AUTO_INCREMENT, 
    ProductName VARCHAR(150) NOT NULL, 
    Price BIGINT NOT NULL, 
    Description VARCHAR(1000) 
);


