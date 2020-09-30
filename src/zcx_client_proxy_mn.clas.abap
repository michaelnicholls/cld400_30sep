class zcx_client_proxy_mn definition
  public
  inheriting from cx_rap_query_provider
  final
  create public .

  public section.
CONSTANTS:
      BEGIN OF remote_access_failed,
        msgid TYPE symsgid VALUE 'Z_CLIENT_PROXI_##',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF remote_access_failed,

      BEGIN OF client_proxy_failed,
        msgid TYPE symsgid VALUE 'Z_CLIENT_PROXI_##',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF client_proxy_failed.
    methods constructor
      importing
        !textid   like if_t100_message=>t100key optional
        !previous like previous optional .
  protected section.
  private section.
endclass.



class zcx_client_proxy_mn implementation.


  method constructor ##ADT_SUPPRESS_GENERATION.
    call method super->constructor
      exporting
        previous = previous.
    clear me->textid.
    if textid is initial.
      if_t100_message~t100key = if_t100_message=>default_textid.
    else.
      if_t100_message~t100key = textid.
    endif.
  endmethod.
endclass.
