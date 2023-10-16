tableextension 50548 "tableextension50548" extends "Sales Line"
{
    // Sr.No.    Emp. ID       Date          Trigger                                      Remarks
    // 1         CSPL-00136    30-04-2019    ShortCut Dimension Code 3 - OnValidate       Code added for Update ShortCut Dimension Code 3 Field
    // 1         CSPL-00136    30-04-2019    No. - OnValidate                             Code added for Update ShortCut Dimension Code 3 Field
    fields
    {

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                //Code added for Assign Value in ShortCut Dimension Code 3 Field::CSPL-00136::30-04-2019: Start
                CLEAR("ShortCut Dimension Code 3");
                DefaultDimension.RESET();
                DefaultDimension.SETRANGE(DefaultDimension."No.", "No.");
                DefaultDimension.SETRANGE(DefaultDimension."Dimension Code", 'OPER. UNIT');
                IF DefaultDimension.FINDFIRST() THEN
                    "ShortCut Dimension Code 3" := DefaultDimension."Dimension Value Code";
               
                //Code added for Assign Value in ShortCut Dimension Code 3 Field::CSPL-00136::30-04-2019: End
            end;
        }
        field(50001; "ShortCut Dimension Code 3"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'ShortCut Dimension Code 3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                //Code added for Assign Value in ShortCut Dimension Code 3 Field::CSPL-00136::30-04-2019: Start
                ValidateShortcutDimCode(3, "ShortCut Dimension Code 3");
                //Code added for Assign Value in ShortCut Dimension Code 3 Field::CSPL-00136::30-04-2019: Start
            end;
        }
    }

    var
        DefaultDimension: Record "Default Dimension";
}

