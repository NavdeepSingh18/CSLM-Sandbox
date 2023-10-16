page 51023 "FERPA Details Lists"
{
    PageType = List;
    SourceTable = "FERPA Details";
    Caption = 'FERPA Details List';
    //ApplicationArea = All;
    UsageCategory = None;
    //DelayedInsert = True;
    AutoSplitKey = true;
    //RefreshOnActivate = True;
    // InsertAllowed = false;
    // DeleteAllowed = false;
    // Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;


                }
                field("Relationship Name"; Rec."Relationship Name")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }

                field("As of Date"; Rec."As of Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = True;

                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = True;

                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field(Addr1; Rec.Addr1)
                {
                    ApplicationArea = All;
                }
                field(Addr2; Rec.Addr2)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                }


            }
            part(FERPAModuleAllowed; "FERPA Module Allowed List")
            {
                //SubPageLink = "Student No." = FIELD("Student No."), Semester = field(Semester), "Academic Year" = field("Academic Year"), Term = field(Term);
                SubPageLink = "Info Header No" = FIELD("Info Header No"), "Ferpa Detail Line No" = field("Ferpa Detail Line No");
                ApplicationArea = All;
            }
        }
    }
    Trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Rec."Student No.", Rec."Academic Year");
        Rec.Ascending(false);

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        FerpaInfoHeader_lRec: Record "FERPA Information Header";
        FerpaDetails_lRec: Record "FERPA Details";
        RecStudentMaster: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;

    Begin
        If StudentNo <> '' then begin
            RecStudentMaster.Reset();
            IF RecStudentMaster.Get(StudentNo) then;

            FerpaInfoHeader_lRec.Reset();
            FerpaInfoHeader_lRec.SetRange("Student No", RecStudentMaster."No.");
            FerpaInfoHeader_lRec.SetRange("Academic Year", RecStudentMaster."Academic Year");
            FerpaInfoHeader_lRec.SetRange(Semester, RecStudentMaster.Semester);
            If Not FerpaInfoHeader_lRec.FindFirst() then begin
                EducationSetupCS.Reset();
                EducationSetupCS.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
                EducationSetupCS.FindFirst();
                EducationSetupCS.TestField(EducationSetupCS."FERPA Info Header No.");
                FerpaInfoHeader_lRec.Init();
                FerpaInfoHeader_lRec."Info Header No" := NoSeriesMgt.GetNextNo(EducationSetupCS."FERPA Info Header No.", 0D, TRUE);
                FerpaInfoHeader_lRec.Validate("Student No", RecStudentMaster."No.");
                FerpaInfoHeader_lRec.Validate("Academic Year", RecStudentMaster."Academic Year");
                FerpaInfoHeader_lRec.Validate(Semester, RecStudentMaster.Semester);
                FerpaInfoHeader_lRec.Validate(Term, RecStudentMaster.Term);
                FerpaInfoHeader_lRec.Validate("Creation Date", Today());
                FerpaInfoHeader_lRec.Validate("Created By", UserId());
                FerpaInfoHeader_lRec.Validate("User ID", UserId());
                FerpaInfoHeader_lRec.Validate("Updated On", Today());
                FerpaInfoHeader_lRec.Validate("Updated By", UserID());
                FerpaInfoHeader_lRec.Insert();

                FerpaDetails_lRec.Reset();
                FerpaDetails_lRec.SetRange("Info Header No", FerpaInfoHeader_lRec."Info Header No");
                If FerpaDetails_lRec.FindLast() then
                    LineNo := FerpaDetails_lRec."Ferpa Detail Line No" + 10000
                Else
                    LineNo := 10000;

                Rec."Info Header No" := FerpaInfoHeader_lRec."Info Header No";
                Rec."Ferpa Detail Line No" := LineNo;
                Rec.Validate("Student No.", RecStudentMaster."No.");
                Rec."E-Mail Address" := RecStudentMaster."Alternate Email Address";

            end;
            If FerpaInfoHeader_lRec.FindFirst() then begin
                FerpaDetails_lRec.Reset();
                FerpaDetails_lRec.SetRange("Info Header No", FerpaInfoHeader_lRec."Info Header No");
                If FerpaDetails_lRec.FindLast() then
                    LineNo := FerpaDetails_lRec."Ferpa Detail Line No" + 10000
                Else
                    LineNo := 10000;

                Rec."Info Header No" := FerpaInfoHeader_lRec."Info Header No";
                Rec."Ferpa Detail Line No" := LineNo;
                Rec.Validate("Student No.", RecStudentMaster."No.");
                Rec."E-Mail Address" := RecStudentMaster."Alternate Email Address";
            end;
        end;
    End;

    Var
        StudentNo: Code[20];

    procedure SetVariable(_StudentNo: Code[20])
    Begin
        StudentNo := _StudentNo;
    End;

}
