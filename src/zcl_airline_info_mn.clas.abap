class zcl_airline_info_mn definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_airline_info_mn implementation.
  method if_oo_adt_classrun~main.
    try.
        data(lo_http_destination) =
               cl_http_destination_provider=>create_by_cloud_destination(
                                             i_name                  = 'HTTP_FSD_MWN'
                                            " i_service_instance_name = 'DESTINATIONS_CLD400'
                                             i_authn_mode            = if_a4c_cp_service=>service_specific ).

        data(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .
        data(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        "set uri path for OData service including the entity to be read
        lo_web_http_request->set_uri_path( |/sap/opu/odata/IWBEP/RMTSAMPLEFLIGHT_2/CarrierCollection?$format=json| ).

        "set request method and execute request
        data(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        data(lv_response) = lo_web_http_response->get_text( ).

      catch cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error into data(lx_exception).
        out->write( lx_exception->get_text( ) ).
    endtry.

    "   out->write( lv_response ).
    types: begin of ty_result,
             AirLineID         type c length 3,
             AirLineName       type c length 30,
             LocalCurrencyCode type c length 3,
             url               type c length 30,
           end of ty_result,

           ty_results type standard table of ty_result with non-unique key AirlineId,

           begin of ty_d,
             results type ty_results,
           end of ty_d,

           begin of ty_json_response,
             d type ty_d,
           end of ty_json_response.

    data: ls_json    type ty_json_response.

    /ui2/cl_json=>deserialize( exporting json = lv_response
                               changing  data = ls_json ).

    if lines( ls_json-d-results ) > 0.
    "  out->write( lines( ls_json-d-results ) ).
      out->write( ls_json-d-results ).
    else.
      out->write( lv_response ).
    endif.
  endmethod.

endclass.
