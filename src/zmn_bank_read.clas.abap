class zmn_bank_read definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class zmn_bank_read implementation.
  method if_oo_adt_classrun~main.
    " This Code Snippet uses the plain HTTP client to access an OData API.
    " Using the more convenient OData client proxy instead requires a service consumption model to be in place.
    " For documentation on how to create a service consumption model see:
    " https://help.sap.com/viewer/c0d02c4330c34b3abca88bdd57eaccfc/DEV_CORR/en-US/5a6e4a72d3db49799bfd00073b2509ab.html
    " and on how to use the OData client proxy see:
    " https://help.sap.com/viewer/c0d02c4330c34b3abca88bdd57eaccfc/Cloud/en-US/98e06f2d2189412699fae82f35f66801.html

    try.
        "create http destination by url; API endpoint for API sandbox
        "     data(lo_http_destination) =
        "          cl_http_destination_provider=>create_by_url(
        "          |https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail| ).
        "alternatively create HTTP destination via destination service
        data(lo_http_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = 'HTTP_SANDBOX_00'
             i_authn_mode = if_a4c_cp_service=>service_specific ).
        "                            i_service_instance_name = '<...>' )
        "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html

        "Available API Endpoints
        "https://{host}:{port}/sap/opu/odata/sap/API_BANKDETAIL_SRV

        "create HTTP client by destination
        data(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers with API Key for API Sandbox
        data(lo_web_http_request) = lo_web_http_client->get_http_request( ).
        lo_web_http_request->set_query( |$filter=BankCountry eq 'AU' | ).
        lo_web_http_request->set_uri_path( |/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail|  ).
        "lo_web_http_request->set_uri_path( |/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail?%24filter=BankCountry%20eq%20'AU'| ).
        lo_web_http_request->set_header_fields( value #(
        (  name = 'Content-Type' value = 'application/json' )
        (  name = 'Accept' value = 'application/json' )
        (  name = 'APIKey' value = 'lfPtPvAeUX4oUOFyBD02wveJue0urTmT' )
         ) ).

        "Available Security Schemes for productive API Endpoints
        "Bearer and Basic Authentication
        "lo_web_http_request->set_authorization_bearer( i_bearer = '<...>' ).
        "lo_web_http_request->set_authorization_basic( i_username = '<...>' i_password = '<...>' ).

        "set request method and execute request
        data(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        data(lv_response) = lo_web_http_response->get_text( ).
        out->write( |length of result: { strlen( lv_response ) } | ).
"        out->write( |{ lv_response } | ).
           TYPES: BEGIN OF ty_result,
             BankCountry    TYPE c LENGTH 2,
             BankInternalID TYPE c LENGTH 10,
             BankName       TYPE c LENGTH 30,
             SWIFTCode      TYPE c LENGTH 20,
             CityName       TYPE c LENGTH 50,
           END OF ty_result,

           ty_results TYPE STANDARD TABLE OF ty_result WITH NON-UNIQUE KEY BankCountry BankInternalID,

           BEGIN OF ty_d,
             results TYPE ty_results,
           END OF ty_d,

           BEGIN OF ty_json_response,
             d TYPE ty_d,
           END OF ty_json_response.

    DATA: lv_json    TYPE ty_json_response.

    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lv_json ).

    IF lines( lv_json-d-results ) > 0.
      out->write( |Lines in table: {  lines( lv_json-d-results ) }| ).
      out->write( lv_json-d-results ).
    ELSE.
      out->write( lv_response ).
    ENDIF.
      catch cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error into data(lx_error) .
        out->write(  | Error { lx_error->get_longtext(   ) }| ).
    endtry.

    "uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main

  endmethod.

endclass.
