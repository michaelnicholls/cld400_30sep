CLASS zcl_generatebookings_mn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generatebookings_mn IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_bookings TYPE TABLE OF ztbooking_jm.

*   read current timestamp
    GET TIME STAMP FIELD DATA(lv_timestamp).

    DATA(lv_timestamp_30) = cl_abap_tstmp=>add( tstmp = lv_timestamp
                                                secs  = ( 3600 * 24 * 30 ) ).

*   fill internal table (itab)
    lt_bookings = VALUE #(
        (
            booking             = '1'
            customername        = 'Jurgen'
            numberofpassengers  = '1'
            emailaddress        = 'jm@flight.example.com'
            country             = 'DE'
            dateofbooking       = lv_timestamp
            dateoftravel        = lv_timestamp_30
            cost                = '100'
            currencycode        = 'EUR'
            lastchangedat       = lv_timestamp
        )
        (
            booking             = '2'
            customername        = 'Ana'
            numberofpassengers  = '4'
            emailaddress        = 'al@flight.example.com'
            country             = 'PT'
            dateofbooking       = lv_timestamp
            dateoftravel        = lv_timestamp_30
            cost                = '500'
            currencycode        = 'USD'
            lastchangedat       = lv_timestamp
        )
    ).

    DELETE FROM ztbooking_mn.
    INSERT ztbooking_mn FROM TABLE @lt_bookings.

    SELECT COUNT( * ) FROM ztbooking_mn INTO @DATA(lv_count).
    out->write( lv_count ).
    out->write( |{ lv_count } records successfully inserted into table ZTBOOKING_MN| ).
  ENDMETHOD.
ENDCLASS.
