page 50368 "Industrial Platform Card-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                Code added for field editable non editable.
    // 02    CSPL-00059   07/02/2019      OnAfterGetRecord()           Code added for field editable non editable.
    // 03    CSPL-00059   07/02/2019      Type Of Course - OnValidate()Code added for field editable non editable.

    PageType = Card;
    SourceTable = "Industrial-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Industrial Platform Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNYR;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for field editable non editable::CSPL-00059::07022019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for field editable non editable::CSPL-00059::07022019: Start
        EditableBTNSEM := TRUE;
        EditableBTNYR := TRUE;
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    var
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
}