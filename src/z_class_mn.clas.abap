CLASS z_class_mn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_class_mn IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( |Hello, world! | ).

  ENDMETHOD.

ENDCLASS.
