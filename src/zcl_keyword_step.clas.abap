CLASS zcl_keyword_step DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES : BEGIN OF NumberTable,
              Number TYPE i,
            END OF numbertable.

    DATA  NumberTables TYPE STANDARD TABLE OF numbertable .

    METHODS : CreateNumber
      RETURNING VALUE(NumberTable) LIKE numbertables.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_keyword_step IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    numbertables = createnumber(  ).


" Step -1 makes the record in acceding order.

    LOOP AT numbertables INTO DATA(numbertable) STEP -1.

      out->write( numbertable-number ).

    ENDLOOP.

  ENDMETHOD.

  METHOD createnumber.

    numbertables = VALUE #(
            FOR i = 1 UNTIL i >= 10
              ( number = i )
    ).

    numbertable = numbertables.

  ENDMETHOD.

ENDCLASS.
