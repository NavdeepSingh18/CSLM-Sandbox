page 50370 "Batch Student Card-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                            Code added for field editable non editable.
    // 02    CSPL-00059   07/02/2019      OnAfterGetRecord()                       Code added for field editable non editable.

    PageType = Card;
    SourceTable = "Batch of Student-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Batch Student Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                }
                field("Batch Code Description"; Rec."Batch Code Description")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                    end;
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("No. Of Student"; Rec."No. Of Student")
                {
                    ApplicationArea = All;
                }
                field("Available Student"; Rec."Available Student")
                {
                    ApplicationArea = All;
                }
            }
        }
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
        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    var
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
}