CLASS lhc_zbj_i_contact DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zbj_i_contact RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zbj_i_contact RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zbj_i_contact.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zbj_i_contact.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zbj_i_contact.

    METHODS read FOR READ
      IMPORTING keys FOR READ zbj_i_contact RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zbj_i_contact.

ENDCLASS.

CLASS lhc_zbj_i_contact IMPLEMENTATION.

  METHOD get_instance_authorizations.



  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.




  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.
