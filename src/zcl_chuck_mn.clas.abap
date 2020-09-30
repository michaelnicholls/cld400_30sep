class zcl_chuck_mn definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_chuck_mn implementation.

  method if_oo_adt_classrun~main.
    try.
        data(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
             i_name = 'Z_CHUCKNORRIS_XXX'
             i_authn_mode = if_a4c_cp_service=>service_specific
             )    .
        data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
             i_destination = lo_destination
        ).
        data(lo_request) = lo_http_client->get_http_request(  ).
        data(lo_response) = lo_http_client->execute(
                i_method = if_web_http_client=>get ).
        out->write( lo_response->get_text( ) ).
      catch cx_root into data(lx_exception).
        out->write(  |Error  {  lx_exception->get_text(   ) }| ).
    endtry.
  endmethod.

endclass.
