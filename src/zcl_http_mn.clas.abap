class zcl_http_mn definition
  public
  create public .

  public section.

    interfaces if_http_service_extension .
  protected section.
  private section.
endclass.



class zcl_http_mn implementation.


  method if_http_service_extension~handle_request.
    data(mydate) = cl_abap_context_info=>get_system_date(  ).
    response->set_text( |Today is {  mydate date = user } | ).
  endmethod.
endclass.
