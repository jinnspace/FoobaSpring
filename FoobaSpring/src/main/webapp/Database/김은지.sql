CREATE OR REPLACE  PROCEDURE getMemberFooba( p_id IN member.id%type, p_curvar OUT SYS_REFCURSOR )
IS
BEGIN
        OPEN  p_curvar  FOR SELECT*FROM member WHERE id = p_id; 
END;


CREATE OR REPLACE  PROCEDURE FimagebyRseq(p_rseq IN NUMBER, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
         OPEN p_cur  FOR select distinct fimage from foodmenu where rseq=p_rseq;
END;

CREATE OR REPLACE  PROCEDURE SearchResList(p_searchtext IN varchar2, p_key OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_key  FOR 
         select rname, rseq, rimage, kind, hash from search where ryn in(1,3) 
         and (fname like '%'||p_searchtext||'%' or hash like '%'||p_searchtext||'%'  or  rname like '%'||p_searchtext||'%') group by rname,rseq,rimage,kind,hash;         
END;



CREATE OR REPLACE  PROCEDURE searchKind(p_kind IN restaurant.kind%TYPE, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_cur  FOR 
        select*from restaurant where kind=p_kind and ryn in(1,3);
END;



CREATE OR REPLACE  PROCEDURE resInf(p_rseq IN restaurant.rseq%TYPE, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_cur  FOR 
        select*from restaurant where rseq=p_rseq;
END;


CREATE OR REPLACE  PROCEDURE reviewList(p_rseq IN review.rseq%TYPE, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_cur  FOR 
        select*from review where rseq=p_rseq order by review_seq desc;
END;

select*from restaurant;

CREATE OR REPLACE  PROCEDURE cartList( p_rseq IN cart.rseq%TYPE,  p_id IN cart.id%TYPE, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_cur  FOR 
        select * from cart where id=p_id and rseq=p_rseq;
END;

CREATE OR REPLACE PROCEDURE foodList( p_rseq IN foodmenu.rseq%type,p_cur OUT SYS_REFCURSOR)
IS
BEGIN
    open p_cur for
            SELECT * FROM foodmenu WHERE rseq = p_rseq; 
end;


CREATE OR REPLACE  PROCEDURE getFoodDetail(p_fseq IN foodmenu.fseq%TYPE, p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN  p_cur  FOR 
        select*from foodmenu where fseq=p_fseq;
END;

CREATE OR REPLACE PROCEDURE insertCartFooba(
    
    p_id  IN cart.id%type,
    p_fseq IN cart.fseq%type,
    p_sideyn1 IN cart.sideyn1%type,
    p_sideyn2 IN cart.sideyn2%type,
    p_sideyn3 IN cart.sideyn3%type,
    p_quantity  IN cart.quantity%type,
    p_cprice  IN cart.cprice%type,
    p_cfname  IN cart.cfname%type,
    p_rseq  IN cart.rseq%type
)
IS

BEGIN
    insert into cart(cseq,id,fseq,sideyn1,sideyn2,sideyn3,quantity,cprice,cfname,rseq)
	values(cart_seq.nextVal,p_id,p_fseq,p_sideyn1,p_sideyn2,p_sideyn3,p_quantity,p_cprice,p_cfname,p_rseq);
    commit;
END;



CREATE OR REPLACE PROCEDURE deletecartFooba( p_cseq IN cart.cseq%TYPE , p_rseq IN cart.rseq%TYPE )
IS
BEGIN
            DELETE FROM cart WHERE cseq = p_cseq;    
END;


CREATE OR REPLACE PROCEDURE CartListFooba(
    p_id IN cart.id%TYPE,
    p_rseq IN cart.rseq%TYPE,
    p_cur OUT SYS_REFCURSOR    
)
IS
BEGIN
        OPEN p_cur FOR
            SELECT * FROM cart WHERE id=p_id and rseq=p_rseq;      
END;


--CREATE OR REPLACE PROCEDURE insertOrdersFooba( p_id IN orders.id%type, p_rideryn IN orders.rideryn%type,
--    p_plasticyn IN orders.plasticyn%type, p_payment IN orders.payment%type, p_address1  IN orders.address1%type, p_address2  IN orders.address2%type,
--    p_address3  IN orders.address3%type, p_phone  IN orders.phone%type,p_totalprice  IN orders.totalprice%type
--)
--IS
--
--BEGIN
--   insert into orders(oseq,id,rideryn,plasticyn,payment,address1,address2,address3,phone,totalprice) 
--   values(orders_seq.nextVal,p_id,p_rideryn,p_plasticyn,p_payment,p_address1,p_address2,p_address3,p_phone, p_totalprice);
--    commit;
--END;
--
--CREATE OR REPLACE PROCEDURE insertOrderFooba(p_id IN orders.id%type,p_oseq IN order_detail.oseq%type,p_quantity IN order_detail.quantity%type,p_fseq IN order_detail.fseq%type,
--p_sideyn1 IN order_detail.sideyn1%type, p_sideyn2 IN order_detail.sideyn2%type,p_sideyn3 IN order_detail.sideyn3%type)
--IS
--
--BEGIN
--    select max(oseq) as max_oseq from orders where id=p_id;
--    insert into order_detail(odseq,oseq,quantity,fseq,sideyn1,sideyn2,sideyn3)
--    values(order_detail_seq.nextVal,p_oseq,p_quantity,p_fseq,p_sideyn1,p_sideyn2,p_sideyn3);
--    commit;
--END;

--    temp_cur SYS_REFCURSOR;
--    v_oseq orders.oseq%type;
--    v_cseq cart.cseq%type;
--    v_quantity cart.quantity%type;
--    v_fseq cart.fseq%type;
--    v_sideyn1 cart.sideyn1%type;
--    v_sideyn2 cart.sideyn2%type;
--    v_sideyn3 cart.sideyn3%type;
--    v_sideyn1_1 number;
--    v_sideyn2_1 number;
--    v_sideyn3_1 number;
--BEGIN  
--    INSERT INTO orders(oseq, rseq, id, rideryn, plasticyn, payment, address1, address2, phone, oname ,totalprice)
--    VALUES(orders_seq.nextVal, p_rseq, p_id, p_rideryn, p_plasticyn, p_payment, p_address1, p_address2, p_phone,p_oname, p_totalprice);
--    select max(oseq) into v_oseq from orders where id=p_id;
--     OPEN temp_cur FOR SELECT cseq, quantity, fseq, sideyn1, sideyn2, sideyn3 FROM cart WHERE id = p_id ;    
--    LOOP
--        FETCH temp_cur INTO v_cseq, v_fseq, v_quantity, v_sideyn1, v_sideyn2, v_sideyn3 ;
--        EXIT WHEN temp_cur%NOTFOUND;        --20��
--        if(v_sideyn1 is null) then v_sideyn1_1 := 0;
--        else v_sideyn1_1 := 1;
--        end if;
--        if(v_sideyn1 is null) then v_sideyn1_1 := 0;
--        else v_sideyn1_1 := 1;
--        end if;
--        if(v_sideyn1 is null) then v_sideyn1_1 := 0;
--        else v_sideyn1_1 := 1;
--        end if;
--        INSERT INTO order_detail(odseq, oseq, quantity, fseq, sideyn1, sideyn2, sideyn3 )
--        VALUES(order_detail_seq.nextVal, v_oseq, v_quantity, v_fseq, v_sideyn1_1, v_sideyn2_1, v_sideyn3_1);
--        DELETE FROM cart WHERE id=p_id;       
--    END LOOP;
--    commit;
--    p_oseq := v_oseq;
--END;

CREATE OR REPLACE PROCEDURE lookupOseq(p_id IN orders.id%type, p_oseq OUT orders.oseq%type)
IS
BEGIN
    select max(oseq)  into p_oseq from orders where id=p_id;
END;

CREATE OR REPLACE PROCEDURE insertOrder_Detail(p_oseq IN order_detail.oseq%type, p_quantity IN order_detail.quantity%type,p_fseq IN order_detail.fseq%type, 
p_sideyn1 IN varchar2,p_sideyn2 IN varchar2,p_sideyn3 IN varchar2)
IS
    v_sideyn1 number;
    v_sideyn2 number;
    v_sideyn3 number;
BEGIN
     if(p_sideyn1 is null) then v_sideyn1 := 0;
        else v_sideyn1 := 1;
        end if;
        if(p_sideyn2 is null) then v_sideyn2 := 0;
        else v_sideyn2 := 1;
        end if;
        if(p_sideyn3 is null) then v_sideyn3 := 0;
        else v_sideyn3 := 1;
        end if;
        INSERT INTO order_detail(odseq, oseq, quantity, fseq, sideyn1, sideyn2, sideyn3 )
        VALUES(order_detail_seq.nextVal, p_oseq, p_quantity, p_fseq, v_sideyn1, v_sideyn2, v_sideyn3);
        commit;
END;

CREATE OR REPLACE PROCEDURE delCart( p_cseq  IN varchar2   )
IS
BEGIN
    DELETE FROM cart WHERE cseq = p_cseq;
    COMMIT;    
END;

CREATE OR REPLACE PROCEDURE insertOrder(p_rseq IN orders.rseq%type, p_id IN orders.id%type, p_rideryn IN orders.rideryn%type,
    p_plasticyn IN orders.plasticyn%type, p_payment IN orders.payment%type, p_address1  IN orders.address1%type, p_address2  IN orders.address2%type,
    p_phone  IN orders.phone%type,p_totalprice  IN orders.totalprice%type,  p_oname  IN orders.oname%type)
IS
BEGIN
    INSERT INTO orders(oseq, rseq, id, rideryn, plasticyn, payment, address1, address2, phone, oname ,totalprice)
    VALUES(orders_seq.nextVal, p_rseq, p_id, p_rideryn, p_plasticyn, p_payment, p_address1, p_address2, p_phone,p_oname, p_totalprice);
    commit;
END;


CREATE OR REPLACE PROCEDURE memberGetAllCount(
    p_cnt  OUT  NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
       SELECT COUNT(*) INTO v_cnt FROM qna;
       p_cnt := v_cnt;
END;

--*****
CREATE OR REPLACE PROCEDURE memberQnaList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR 
        SELECT*FROM(
        SELECT*FROM(
        SELECT rownum as rn, q.*FROM((SELECT*FROM qna ORDER BY qseq desc)q)
        ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;

-- *****
alter table orders add oname varchar2(100);


create or replace view order_view
as
select a.oseq, a.result, a.oname, a.indate, a.id, a.rideryn, a.plasticyn, a.payment, a.address1 as oadd1, a.address2 as oadd2, a.phone as ophone, a.totalprice,
      b.odseq, b.quantity, b.fseq, b.sideyn1, b.sideyn2, b.sideyn3,
      c.nick, c.address1 as madd1, c.address2 as madd2, c.phone as mphone,
      d.fname, d.fprice, d.fside1, d.fside2, d.fside3, d.fsideprice1, d.fsideprice2, d.fsideprice3, d.fimage, d.fcontent,
      e.rname, e.rseq, e.rimage, e.rtip, e.ryn
from orders a, order_detail b, member c, foodmenu d, restaurant e
where a.oseq=b.oseq and a.id = c.id and b.fseq=d.fseq and d.rseq=e.rseq;



-- *****
INSERT INTO order_detail(odseq, oseq, quantity, fseq, sideyn1, sideyn2, sideyn3 )
VALUES(order_detail_seq.nextVal, 1, v_quantity, v_fseq, v_sideyn1, v_sideyn2, v_sideyn3);

create or replace procedure bannerx(p_cur out sys_refcursor)
is
begin
    open p_cur for
        select*from bannerf where border<=3 order by border;
end;

CREATE OR REPLACE PROCEDURE insertMember(
    p_id IN member.id%TYPE,
    p_pwd IN member.pwd%TYPE,
    p_name IN member.name%TYPE,
    p_email IN member.email%TYPE,
    p_phone IN member.phone%TYPE,
    p_zip_num IN member.zip_num%TYPE,
    p_address1 IN member.address1%TYPE,
    p_address2 IN member.address2%TYPE,
    p_address3 IN member.address3%TYPE,
    p_nick IN member.nick%TYPE 
)
IS
BEGIN
    INSERT INTO member( id, pwd, name, email, phone, zip_num, address1, address2, address3, nick)
    VALUES( p_id, p_pwd, p_name, p_email, p_phone, p_zip_num, p_address1, p_address2, p_address3, p_nick );
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE getOrderIngCount( p_id IN orders.id%TYPE, p_cnt  OUT  NUMBER)
IS
BEGIN
       select count(rownum) into p_cnt from orders where id=p_id and result in(0,1);
END;

delete from order_detail;
delete from orders;

CREATE OR REPLACE PROCEDURE selectOrdersById( p_id IN orders.id%TYPE, p_oa IN varchar2, p_startNum IN NUMBER, p_endNum IN NUMBER, p_cur OUT SYS_REFCURSOR)
IS
BEGIN
    IF(p_oa ='��������')then 
    OPEN p_cur FOR
       select * from ( select * from ( select rownum as rn, b.* from 
       (( select distinct oseq,rseq,oname,rname,rimage,indate,result,totalprice from order_view where id=p_id and result in(0,1) order by oseq desc) b)) where rn>=p_startNum ) where rn<=p_endNum;
    ELSE
     OPEN p_cur FOR
       select * from ( select * from ( select rownum as rn, b.* from 
       (( select distinct oseq,rseq,oname,rname,rimage,indate,result,totalprice from order_view where id=p_id  order by oseq desc) b)) where rn>=p_startNum ) where rn<=p_endNum;
    END IF;
END;
commit;