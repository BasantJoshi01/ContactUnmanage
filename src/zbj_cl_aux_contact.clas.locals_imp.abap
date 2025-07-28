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
                it_contactx      TYPE  zbj_cl_aux_contact=>lt_contactx
                iv_deletecheck   TYPE abap_boolean  OPTIONAL
                iv_numberingmode TYPE c  DEFAULT zbj_cl_aux_contact=>ls_constants-numbering_mode-late
      EXPORTING
                et_contact       TYPE zbj_cl_aux_contact=>lt_contact
                et_messages      TYPE zbj_cl_aux_contact=>lt_messages.





  PRIVATE SECTION.

    CLASS-DATA : go_instance TYPE REF TO lcl_buffer_contact.

    METHODS  : _create
      IMPORTING
        it_contact       TYPE zbj_cl_aux_contact=>lt_contact
        iv_numberingmode TYPE c  DEFAULT zbj_cl_aux_contact=>ls_constants-numbering_mode-late
      EXPORTING
        et_contact       TYPE zbj_cl_aux_contact=>lt_contact
        ev_messages      TYPE zbj_cl_aux_contact=>lt_messages
      RAISING
        cx_uuid_error.


ENDCLASS.

CLASS lcl_buffer_contact IMPLEMENTATION.

  METHOD get_instance.

    ro_instance = COND #(

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

    CHECK : it_contact IS NOT INITIAL.

    LOOP AT it_contact  INTO DATA(ls_contact).

      DATA(ls_contactx) = VALUE #( it_contactx[ contact_id = ls_contact-contact_id ] OPTIONAL ).

      IF ls_contactx IS INITIAL.

        "  This expression creates a new table that consists of all prior message entries plus this newly appended one.
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

      CASE ls_contactx-action_code.
        WHEN zbj_cl_aux_contact=>ls_constants-operation_action-create.
          APPEND ls_contact TO lt_b4c.
        WHEN zbj_cl_aux_contact=>ls_constants-operation_action-update.
          APPEND ls_contact TO lt_b4u.
        WHEN zbj_cl_aux_contact=>ls_constants-operation_action-delete.
          APPEND ls_contact TO lt_b4d.
      ENDCASE.

    ENDLOOP.

    " Now we will move the data from tran. buffer to main table using a private method.

    TRY.
        _create(
          EXPORTING
            it_contact       =   lt_b4c
            iv_numberingmode = zbj_cl_aux_contact=>ls_constants-numbering_mode-late
          IMPORTING
            et_contact       =  et_contact
            ev_messages      =  et_messages
        ).
      CATCH cx_uuid_error.
    ENDTRY.


  ENDMETHOD.



  METHOD _create.

    CLEAR :  et_contact ,  ev_messages.

    CHECK : it_contact IS NOT INITIAL.

    " All Validations will be done here

    " get Numbering Generated in case of Late Numbering

    LOOP AT it_contact  INTO DATA(Contact).

      IF iv_numberingmode = zbj_cl_aux_contact=>ls_constants-numbering_mode-late.

        Contact-created_by = 'LATE'.

      ELSE.
        TRY.
            Contact-contact_id = cl_system_uuid=>create_uuid_x16_static(  ).
          CATCH cx_uuid_error.
        ENDTRY.

        Contact-created_by = cl_abap_context_info=>get_user_technical_name(  ).

      ENDIF.

      GET TIME STAMP FIELD Contact-created_at.

      Contact = VALUE #( last_changed_at = Contact-created_at
                            last_changed_by  = cl_abap_context_info=>get_user_technical_name(  )
      ).


      INSERT Contact INTO mt_b4c.

    ENDLOOP.

    et_contact = mt_b4c.

  ENDMETHOD.

ENDCLASS.
