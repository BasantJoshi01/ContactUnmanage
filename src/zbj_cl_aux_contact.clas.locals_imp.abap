CLASS lcl_buffer_contact DEFINITION FINAL CREATE PRIVATE.

  PUBLIC SECTION.

    " Transectional buffer create update and delete

    DATA : mt_b4c TYPE zbj_cl_aux_contact=>lt_contact,
           mt_b4u TYPE zbj_cl_aux_contact=>lt_contact,
           mt_b4d TYPE zbj_cl_aux_contact=>lt_contact.


    DATA: mt_a4c TYPE zbj_cl_aux_contact=>lt_contact,
          mt_a4u TYPE zbj_cl_aux_contact=>lt_contact,
          mt_a4d TYPE zbj_cl_aux_contact=>lt_contact.


    CLASS-METHODS : get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO lcl_buffer_contact.

    METHODS : prepare_transactional_buffer


      IMPORTING it_contact       TYPE zbj_cl_aux_contact=>lt_contact
                it_contactx      TYPE zbj_cl_aux_contact=>lt_contact
                iv_deletecheck   TYPE abap_boolean  OPTIONAL
                iv_numberingmode TYPE c  DEFAULT zbj_cl_aux_contact=>ls_constants-numbering_mode-late
      EXPORTING
                et_contact       TYPE zbj_cl_aux_contact=>lt_contact
                et_messages      TYPE zbj_cl_aux_contact=>lt_messages.





  PRIVATE SECTION.

    CLASS-DATA : go_instance TYPE REF TO lcl_buffer_contact.



ENDCLASS.

CLASS lcl_buffer_contact IMPLEMENTATION.

  METHOD get_instance.

    go_instance = COND #(

        WHEN go_instance IS BOUND
        THEN go_instance ELSE NEW #(  )
     ).





  ENDMETHOD.


  METHOD prepare_transactional_buffer.

    DATA : lt_b4c  TYPE zbj_cl_aux_contact=>lt_contact,
           lt_b4u  TYPE zbj_cl_aux_contact=>lt_contact,
           lt_b4d  TYPE zbj_cl_aux_contact=>lt_contact,
           lt_b4ux TYPE zbj_cl_aux_contact=>lty_contact_intx.


    CLEAR : et_contact , et_messages.
    CHECK : it_contact IS INITIAL.

    LOOP AT it_contact  INTO DATA(ls_contact).

      DATA(ls_Contactx) = VALUE #( it_contactx[ contact_id = ls_contact-contact_id ] OPTIONAL ).

      IF ls_contactx IS INITIAL.

        et_messages = VALUE #( BASE et_messages
            ( " Message Class Name
              msgid = zbj_cl_aux_contact=>ls_constants-message_id
              " Message Number
              msgno = '000'
              msgty =  if_abap_behv_message=>severity-error
              " Dynamic  Variable to Pass in Message
              msgv1 =  ls_contact-contact_id ) ).

        RETURN.
      ENDIF.

    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
