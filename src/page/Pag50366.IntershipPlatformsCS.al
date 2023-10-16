page 50366 "Intership Platforms-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Post - OnAction()                Code added for Post record.
    // 02    CSPL-00059   07/02/2019      Get Student - OnAction()          Code added for Get Student detials.

    PageType = Card;
    SourceTable = "Student Intership Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
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
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Industrial Program"; Rec."Industrial Program")
                {
                    ApplicationArea = All;
                }
            }
            part("<IntershipLine>"; "Appl Prequal Marks Detail-CS")
            {
                Caption = ' IntershipLine';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Post")
            {
                Caption = '&Post';
                action(Post)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Post record::CSPL-00059::07022019: Start
                        IF CONFIRM(Text001Lbl, TRUE) THEN BEGIN
                            Rec.Posted := TRUE;
                            Rec.PostStudentCS();
                            MESSAGE(Text002Lbl);
                        END;
                        //Code added for Post record::CSPL-00059::07022019: Start
                    end;
                }
            }
            // group("Function")
            // {
            //     Caption = 'Fu&nction';
            //     action("Get Student")
            //     // {
            //     //     ApplicationArea = All;
            //     //     trigger OnAction()
            //     //     begin
            //     //         //Code added for Get Student detials::CSPL-00059::07022019: End
            //     //         IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN
            //     //             GetStudentCS(Rec."Global Dimension 1 Code", Rec."Type Of Course", Rec.Semester, Course, "No.", "Industrial Program", Section, Rec.Session)
            //     //         ELSE
            //     //             GetStudentYRCS(Rec."Global Dimension 1 Code", Rec."Type Of Course", Rec.Year, Rec.Course, Rec."No.", Rec."Industrial Program", Rec.Section, Rec.Session);
            //     //         //Code added for Get Student detials::CSPL-00059::07022019:End
            //     //     end;
            //     // }
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
    end;

    trigger OnOpenPage()
    begin
        EditableBTNYR := TRUE;
        EditableBTNSEM := TRUE;

        IF Rec.Posted = TRUE THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        EditableBTNYR: Boolean;
        EditableBTNSEM: Boolean;
        Text001Lbl: Label 'Do you want post students';
        Text002Lbl: Label 'Student Post';
}