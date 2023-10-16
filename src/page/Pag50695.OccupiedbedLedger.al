page 50695 "Room Wise Bed Detail"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Room Wise Bed";
    Caption = 'Apartment Wise Room Detail';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(group)
            {

                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;

                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;

                }
                field("Student No"; StudentNo)
                {
                    Caption = 'Student ID';
                    ApplicationArea = All;

                }
                field("Student Name"; StudentName)
                {
                    Caption = 'First Name';
                    ApplicationArea = All;

                }
                Field(LastName; LastName)
                {
                    Caption = 'Last Name';
                    ApplicationArea = All;
                }
                field(EmailAddress; EmailAddress)
                {
                    Caption = 'E-mail Address';
                    ApplicationArea = All;
                }
                field(Semester; Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;

                }
                field("Academic Year"; AdYear)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    var
        HousingLedger: Record "Housing Ledger";
        StudentMaster: Record "Student Master-CS";
        StudentNo: Code[20];
        StudentName: Text[100];
        Semester: Code[20];
        AdYear: Code[20];
        Assigned: Integer;
        LastName: Text;
        EmailAddress: Text;


    trigger OnAfterGetRecord()
    begin
        StudentNo := '';
        StudentName := '';
        Semester := '';
        AdYear := '';
        LastName := '';
        EmailAddress := '';
        HousingLedger.Reset();
        HousingLedger.SetRange("Housing ID", Rec."Housing ID");
        HousingLedger.SetRange("Room No.", Rec."Room No.");
        HousingLedger.SetRange("Bed No.", Rec."Bed No.");
        HousingLedger.CalcSums("Room Assignment");
        Assigned := HousingLedger."Room Assignment";
        if Assigned <> 0 then begin
            If HousingLedger.FindLast() then begin
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", HousingLedger."Student No.");
                If StudentMaster.FindFirst() then begin
                    StudentNo := StudentMaster."Original Student No.";
                    StudentName := StudentMaster."First Name";
                    Semester := HousingLedger.Semester;
                    AdYear := HousingLedger."Academic Year";
                    LastName := StudentMaster."Last Name";
                    EmailAddress := StudentMaster."E-Mail Address";
                end;
            end;
        End;
    end;

}