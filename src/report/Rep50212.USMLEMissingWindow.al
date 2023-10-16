report 50212 "USMLE Missing Window"
{
    Caption = 'USMLE Missing Window Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './src/reportrdlc/USMLE Missing Window.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("USMLE Performance Data"; "USMLE Performance Data")
        {
            DataItemTableView = where("Result Matched" = filter(true));

            column(Student_ID; StudentMasterRec."Original Student No.")
            { }
            column(SLcM_No; StudentMasterRec."No.")
            {

            }
            column(Enrollemnt_No; StudentMasterRec."Enrollment No.")
            {

            }
            column(StudentName; StudentMasterRec."Student Name")
            {

            }
            column(Course_Code; StudentMasterRec."Course Code")
            {

            }
            column(Academic_Year; StudentMasterRec."Academic Year")
            {

            }
            column(Status; StudentMasterRec.Status)
            {

            }
            column(UsmleID; "USMLE Performance Data"."USMLE ID")
            {

            }

            column(Logo; EducationSetup_Rec."Logo Image")
            {

            }
            column(Institute_Name; EducationSetup_Rec."Institute Name")
            {

            }

            // RequestFilterFields = USMLEID, "Academic Year";

            trigger OnPreDataItem()
            begin
                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Logo Image");
            end;

            trigger OnAfterGetRecord()
            begin

                // if StudentStatusRec.Get("Student Master-CS".Status, "Student Master-CS"."Global Dimension 1 Code") then
                //     if (StudentStatusRec.Status in [StudentStatusRec.Status::Deferred, StudentStatusRec.Status::Declined,
                //     StudentStatusRec.Status::Suspension, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                //     StudentStatusRec.Status::Deceased, StudentStatusRec.Status::Graduated, StudentStatusRec.Status::TOPROG]) then
                //         CurrReport.Skip();


                USMLERec.Reset();
                USMLERec.SetCurrentKey("Creation Date");
                USMLERec.Ascending(false);
                USMLERec.SetRange(UsmleID, "USMLE Performance Data"."USMLE ID");
                IF "USMLE Performance Data"."Step Exam" = "USMLE Performance Data"."Step Exam"::"STEP 1" then
                    USMLERec.SetRange(USMLEStepNumber, '1');
                IF "USMLE Performance Data"."Step Exam" = "USMLE Performance Data"."Step Exam"::"STEP 2 CK" then
                    USMLERec.SetRange(USMLEStepNumber, 'CK');
                IF "USMLE Performance Data"."Step Exam" = "USMLE Performance Data"."Step Exam"::"STEP 2 CS" then
                    USMLERec.SetRange(USMLEStepNumber, 'CS');
                USMLERec.Setrange(Block, False);
                USMLERec.SetFilter(USMLEWindowStartDate, '<=%1', "USMLE Performance Data"."Date of Exam");
                USMLERec.SetFilter(USMLEWindowEndDate, '>=%1', "USMLE Performance Data"."Date of Exam");
                if USMLERec.FindFirst() then
                    CurrReport.Skip();

                StudentMasterRec.Reset();
                StudentMasterRec.SetRange(UsmleID, "USMLE Performance Data"."USMLE ID");
                IF StudentMasterRec.FindFirst() then;
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field("Exam Type"; ScoreType)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //                 field("Sitting Date"; SittingDate)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }

    //         }
    //     }

    // }

    trigger OnPreReport()
    Begin
        // IF ScoreType = ScoreType::" " then
        //     Error('Exam Type must have a value');
        // If SittingDate = 0D then
        //     Error('Sitting Date must have a value');

    End;


    var
        StudentStatusRec: Record "Student Status";
        StudentMasterRec: Record "Student Master-CS";
        EducationSetup_Rec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        USMLERec: Record USMLE;


}
