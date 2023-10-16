page 50317 "Student Header (CBCS)-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019     <Action1102155033> - OnAction()            Code added for data updation.
    // 02    CSPL-00059   14/02/2019     OnAfterGetCurrRecord()-Function            Code added for get data other table.
    // 03    CSPL-00059   14/02/2019     OnAfterGetRecord()                         Code added for call function.
    // 04    CSPL-00059   14/02/2019     OnNewRecord                                Code added for call function.

    Caption = 'Student Header (CBCS)';
    PageType = Card;
    SourceTable = "CBCS Student Head-CS";

    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Specialization"; Rec."Student Specialization")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Min Credit"; Rec."Min Credit")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Credit Acheived"; Rec."Credit Acheived")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total no of Elective"; Rec."Total no of Elective")
                {
                    ApplicationArea = All;
                }
                field("Min Electives-Specialization"; Rec."Min Electives-Specialization")
                {
                    ApplicationArea = All;
                }
                field("Max Electives-Others"; Rec."Max Electives-Others")
                {
                    ApplicationArea = All;
                }
                field("Electives-Specialization Taken"; Rec."Electives-Specialization Taken")
                {
                    ApplicationArea = All;
                }
                field("Electives-Others Taken"; Rec."Electives-Others Taken")
                {
                    ApplicationArea = All;
                }
                field("Total no of Elective Taken"; Rec."Total no of Elective Taken")
                {
                    ApplicationArea = All;
                }
            }
            part("Student Line(CBCS)-CS"; 50318)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("S&tudent CBCS Reg&istration")
            {
                Caption = 'S&tudent CBCS Reg&istration';
                action("&Update")
                {
                    Caption = '&Update';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for data updation::CSPL-00059::14022019: Start
                        IF SpecializationCS.GET(Rec."Student Specialization") THEN BEGIN
                            IF SpecializationCS."Effective Till" = Rec."Semester Code" THEN
                                CBCSStudentLineCS.Reset();
                            CBCSStudentLineCS.SETRANGE("Document No.", Rec."No.");
                            CBCSStudentLineCS.SETRANGE(Specilization, Rec."Student Specialization");
                            IF (Rec."Electives-Specialization Taken" + CBCSStudentLineCS.Count()) < Rec."Min Electives-Specialization" THEN
                                ERROR(Text000Lbl, Rec."Min Electives-Specialization");
                            CBCSStudentLineCS.Reset();
                            CBCSStudentLineCS.SETRANGE("Document No.", Rec."No.");
                            CBCSStudentLineCS.SETRANGE(Specilization, '');
                            IF (Rec."Electives-Others Taken" + CBCSStudentLineCS.Count()) > Rec."Max Electives-Others" THEN
                                ERROR(Text001Lbl, Rec."Max Electives-Others");
                            CBCSStudentLineCS.Reset();
                            CBCSStudentLineCS.SETRANGE("Document No.", Rec."No.");
                            CBCSStudentLineCS.SETRANGE("CBCS Status", CBCSStudentLineCS."CBCS Status"::Applied);
                            IF (Rec."Total no of Elective Taken" + CBCSStudentLineCS.Count()) <> Rec."Total no of Elective" THEN
                                ERROR(Text002Lbl, Rec."Total no of Elective");
                        END;
                        //Code added for data updation::CSPL-00059::14022019: End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for call function::CSPL-00059::14022019: Start
        CSOnAfterGetCurrRecord();
        //Code added for call function::CSPL-00059::14022019: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for call function::CSPL-00059::14022019: Start
        CSOnAfterGetCurrRecord();
        //Code added for call function::CSPL-00059::14022019: End
    end;

    var

        CBCSStudentLineCS: Record "CBCS Student Line-CS";

        SpecializationCS: Record "Specialization-CS";
        Text000Lbl: Label 'Minimum Electives for Specilization is %1';
        Text001Lbl: Label 'Maximum Electives for Specilization is %1';
        Text002Lbl: Label 'Total Electives should be %1';

    local procedure CSOnAfterGetCurrRecord()
    begin
        //Code added for get data other table::CSPL-00059::14022019: Start
        xRec := Rec;
        IF SpecializationCS.GET(Rec."Student Specialization") THEN BEGIN
            Rec."Total no of Elective" := SpecializationCS."Total no of Elective";
            Rec."Min Electives-Specialization" := SpecializationCS."Min Electives-Specialization";
            Rec."Max Electives-Others" := SpecializationCS."Max Electives-Others";
        END ELSE BEGIN
            Rec."Total no of Elective" := 0;
            Rec."Min Electives-Specialization" := 0;
            Rec."Max Electives-Others" := 0;

        END;
        Rec."Total no of Elective Taken" := Rec."Electives-Specialization Taken" + Rec."Electives-Others Taken";
        //Code added for get data other table::CSPL-00059::14022019: End
    end;
}