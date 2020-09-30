CLASS zcl_bank_read_client_proxy_mn DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS:
      get_client_proxy RETURNING VALUE(ro_client_proxy) TYPE REF TO /iwbep/if_cp_client_proxy
                       RAISING   zcx_client_proxy.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_bank_read_client_proxy_mn IMPLEMENTATION.
  METHOD get_client_proxy.
    " Get the destination of foreign system
    TRY.
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                                  cl_http_destination_provider=>create_by_cloud_destination(
                                        i_name                  = |FSD_HTTP|      " <-- your destination
"                                        i_service_instance_name = |DESTINATIONS_CLD400|    " <-- SIN of Communication Arrangement
                                        i_authn_mode            = if_a4c_cp_service=>service_specific
                                     ) ).

        DATA(lo_web_http_request) = lo_http_client->get_http_request( ).

        lo_web_http_request->set_header_fields( VALUE #(
                (  name = 'Content-Type' value = 'application/json' )
                (  name = 'Accept' value = 'application/json' )
***             (  name = 'APIKey' value = ' Add your API KEY if required ' )
                 ) ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        RAISE EXCEPTION TYPE zcx_client_proxy_mn
          EXPORTING
            textid   = zcx_client_proxy_mn=>remote_access_failed
            previous = lx_http_dest_provider_error.

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        RAISE EXCEPTION TYPE zcx_client_proxy_mn
          EXPORTING
            textid   = zcx_client_proxy_mn=>remote_access_failed
            previous = lx_web_http_client_error.
    ENDTRY.

    " Instantiation of client proxy
    TRY.
        ro_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
                                        EXPORTING
                                          iv_service_definition_name = 'Z_BANK_READ_C_A_MN'
                                          io_http_client             = lo_http_client
                                          iv_relative_service_root   = '/sap/opu/odata/sap/API_BANKDETAIL_SRV/' ).

      CATCH cx_web_http_client_error INTO lx_web_http_client_error.
        RAISE EXCEPTION TYPE zcx_client_proxy
          EXPORTING
            textid   = zcx_client_proxy_mn=>client_proxy_failed
            previous = lx_web_http_client_error.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE EXCEPTION TYPE zcx_client_proxy_mn
          EXPORTING
            textid   = zcx_client_proxy_mn=>client_proxy_failed
            previous = lx_gateway.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
