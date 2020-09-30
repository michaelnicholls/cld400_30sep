class zmn_demo definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zmn_demo implementation.
  method if_oo_adt_classrun~main.
    data(hhh) = 10.
    subtract 1 from hhh.

    select * from /dmo/carrier into table @data(lt_carrier).

  endmethod.

endclass.
