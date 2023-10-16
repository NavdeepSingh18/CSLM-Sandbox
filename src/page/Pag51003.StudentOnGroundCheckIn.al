page 51003 "Student On Ground CheckIn"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StudentOnGroundCheckIn;
    SourceTableView = Where(Confirmed = filter(false));
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec.StudentNo)
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec.StudentName)
                {
                    ApplicationArea = All;

                }
                field("OLR Academic Year"; Rec."OLR Academic Year")
                {
                    ApplicationArea = All;

                }
                Field("OLR Semester"; Rec."OLR Semester")
                {
                    ApplicationArea = All;

                }
                Field("OLR Term"; Rec."OLR Term")
                {
                    ApplicationArea = All;

                }
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                Field(OLRCompleted; Rec.OLRCompleted)
                {
                    ApplicationArea = All;

                }
                Field(OLRCompletedDate; Rec.OLRCompletedDate)
                {
                    ApplicationArea = All;

                }
                Field(StudentOnGroundGroup; Rec.StudentOnGroundGroup)
                {
                    ApplicationArea = All;

                }
                Field("On Ground Check-In On"; Rec."On Ground Check-In On")
                {
                    ApplicationArea = All;

                }
                Field("On Ground ChkIn Completed On"; Rec."On Ground ChkIn Completed On")
                {
                    ApplicationArea = All;

                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(StudentOnGroudXMLPort)
            {
                Caption = 'On Ground Check In (XMLPort)';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    XMLPort61000: XmlPort StudentOnGroundCheckIn;
                begin
                    Clear(XMLPort61000);
                    XMLPort61000.Run();
                end;
            }
            action(StudentOnGroundCheckInProcess)
            {
                Caption = 'On Ground Check In Process';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    StudentOnGroundCheckIn_lRec: Record StudentOnGroundCheckIn;
                    CU50034: Codeunit WebServicesFunctionsCSL;

                Begin
                    If not Confirm('Do you want to confirm the process?', false) then
                        exit;

                    CurrPage.SetSelectionFilter(StudentOnGroundCheckIn_lRec);
                    IF StudentOnGroundCheckIn_lRec.FindSet() then begin
                        repeat
                            Studentongroundcheckin_New(StudentOnGroundCheckIn_lRec.StudentNo);
                            //CU50034.StudentOnGroundCheckInBCtoPortal(StudentOnGroundCheckIn_lRec);
                            StudentOnGroundCheckIn_lRec.Confirmed := true;
                            StudentOnGroundCheckIn_lRec.Modify();
                        until StudentOnGroundCheckIn_lRec.Next() = 0;
                    end;
                    Message('Updated Successfully');
                    CurrPage.Update();

                end;

            }
        }
    }

    procedure Studentongroundcheckin_New(StudentNo: Code[20])
    var
        Stud: Record "Student Master-CS";
        HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
    begin
        if StudentNo = '' then
            Error('Student No. cannot be empty while sending information about Student OnGround Check-In.');

        Stud.Reset();
        Stud.Get(StudentNo);
        if not Stud."OLR Completed" then
            //Error('OLR must be completed before On-Ground Check-In');
            Error('Due to some server issue, please try again later.');

        Stud."Student Group" := Stud."Student Group"::"On-Ground Check-In";
        Stud."On Ground Check-In On" := Today();
        Stud."On Ground Check-In By" := StudentNo;
        HoldUpdate_lCU.OnGroundCheckInStudentGroupEnable(StudentNo);
        Stud.Modify();
    end;


}