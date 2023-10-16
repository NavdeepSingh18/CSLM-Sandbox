page 50118 "Multi Evt Entry Edu Cale-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                   Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  12-08-19   OnQueryClosePage()                       Code added for validation.
    // 02.   CSPL-00174  12-08-19   Revise & Generate Event - OnAction()     Code added for revise & Generate Event.
    // 03.   CSPL-00174  12-08-19   Genrate Event - OnAction()               Code added create Event.
    // 04.   CSPL-00174  12-08-19   Delete Event - OnAction()                Code added for delete Event.

    Caption = 'Multi Evt Entry';
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = None;
    SourceTable = "Education Multi Event Cal-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Even/Odd Semester"; Rec."Even/Odd Semester")
                {
                    ApplicationArea = All;
                    Caption = 'Term';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                }
                field("Event Description"; Rec."Event Description")
                {
                    ApplicationArea = All;
                }
                field("Event Day Calculation"; Rec."Event Day Calculation")
                {
                    ApplicationArea = All;
                }
                field("Revised End Date"; Rec."Revised End Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Revised; Rec.Revised)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Action")
            {
                action("Revise & Generate Event")
                {
                    ApplicationArea = All;
                    Image = ChangeBatch;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Code added for revise & Generate Event::CSPL-00174::120819: Start
                        EducationTimeTableCS.CheckAndUpdate(Rec.Code, Rec."Event Code", Rec."Academic Year", Rec.Semester, Rec.Year, Rec.Date, Rec."Start Date", Rec."Even/Odd Semester");
                        //Code added for revise & Generate Event::CSPL-00174::120819: End
                    end;
                }
                action("Genrate Event")
                {
                    ApplicationArea = All;
                    Image = CreateMovement;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Code added create Event::CSPL-00174::120819: Start
                        EducationTimeTableCS.CreateMultipleLine(Rec.Code, Rec.Date, Rec."Event Code", Rec."Academic Year", Rec."Even/Odd Semester");
                        //Code added create Event::CSPL-00174::120819: End
                    end;
                }
                action("Delete Event")
                {
                    ApplicationArea = All;
                    Image = Delete;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Code added for delete Event::CSPL-00174::120819: Start
                        Rec.TESTFIELD("Start Date", Rec.Date);
                        EducationMultiEventCalCS.Reset();
                        EducationMultiEventCalCS.SETRANGE(EducationMultiEventCalCS.Code, Rec.Code);
                        EducationMultiEventCalCS.SETRANGE(EducationMultiEventCalCS."Event Code", Rec."Event Code");
                        EducationMultiEventCalCS.SETRANGE(EducationMultiEventCalCS."Academic Year", Rec."Academic Year");
                        IF Rec.Semester <> '' THEN
                            EducationMultiEventCalCS.SETRANGE(EducationMultiEventCalCS.Semester, Rec.Semester)
                        ELSE
                            EducationMultiEventCalCS.SETRANGE(EducationMultiEventCalCS.Year, Rec.Year);
                        IF EducationMultiEventCalCS.FINDSET() THEN
                            IF CONFIRM(Text001Lbl, FALSE) THEN
                                EducationMultiEventCalCS.DELETEALL();

                        //Code added for delete Event::CSPL-00174::120819: End
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //Code added for validation::CSPL-00174::120819: Start
        IF Rec.Revised = TRUE THEN
            ERROR('<<  You Have To Revise The Event. >>');
        //Code added for validation::CSPL-00174::120819: End
    end;

    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationTimeTableCS: Codeunit "Education Time Table-CS";

        Text001Lbl: Label 'Do You Want To Delete!!';

}