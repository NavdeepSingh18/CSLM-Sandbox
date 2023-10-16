report 50000 StudentStatusChangesADWD//GAURAV//14.8.22//
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/StudentStatusChangeADWD.rdl';

    dataset
    {
        dataitem(Studentmaster; "Student Master-CS")
        {
            Column(StudentName; Studentmaster."Student Name")
            { }
            Column(Addr; Studentmaster.Addressee + ' ' + Studentmaster.Address1)
            {
            }
            Column(DataItemName1; Studentmaster.City + ' ' + Studentmaster.State + ' ' + Studentmaster."Post Code")
            {
            }
            Column(FirstName; Studentmaster."First Name")
            {
            }
            column(Today_; Format(Today(), 0, '<Month Text> <Closing><Day>, <Year4>'))
            {

            }
            column(TerYear; Format(Studentmaster.Term) + ' ' + Studentmaster."Academic Year" + ' semester')
            {

            }
            column(UserSetupSignature; UserSetup.Signature)
            {

            }
            column(UserName; USerName)// User."Full Name")
            {

            }
            column(UserName2; USerName2)// User."Full Name")
            {

            }
            column(Comment_gText; Comment_gText1)
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
                Caption = 'InstitueCode';

            }
            //column(UserSetupUserID; UserSetup."User ID")
            // {

            // }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SemesterMasterCS: Record "Semester Master-CS";
                User_lRec: Record User;

            begin
                USerName := '';
                UserName2 := '';
                Clear(UserSetup);
                IF UserSetup.Get(UserId) then
                    UserSetup.CalcFields(Signature);


                SemesterMasterCS.Reset();
                SemesterMasterCS.SetRange(code, Semester);
                IF SemesterMasterCS.FindFirst() then
                    IF SemesterMasterCS.Sequence < 6 Then begin
                        UserName2 := UserSetup."Job Title";
                        User_lRec.Reset();
                        User_lRec.SetRange(User_lRec."User Name", UserSetup."User ID");
                        IF User_lRec.FindFirst() then
                            USerName := User_lRec."Full Name";
                    end else begin
                        USerName := 'Melissa Morell';
                        Clear(UserSetup);
                        IF UserSetup.Get('MMORELL@AUAMED.NET') then;
                        UserSetup.CalcFields(Signature);
                        UserName2 := UserSetup."Job Title";
                    end;
                Comment_gText1 := '';
                If Comment_gText <> '' Then
                    Comment_gText1 := Comment_gText
                else
                    Comment_gText1 := ' ';
            end;

            trigger OnPreDataItem()
            var
            //    StudentStatusChangesADWD: Codeunit "StudentStatusChangesADWD";
            begin
                //  SetRange("No.", StudentStatusChangesADWD.ReturnSchName());

                if StudentNo_gCod <> '' then
                    SetRange("No.", StudentNo_gCod);
                //message(StudentNo_gCod);
            end;
        }

    }
    var
        UserSetup: Record "User Setup";
        USerName: Text[100];
        StudentNo_gCod1: Code[20];
        User: Record User;
        UserName2: text;
        StudentNo_gCod: Code[20];
        Comment_gText: Text;


    procedure SetStudent_gFnc(StudNo_iCod: Code[20])
    begin
        StudentNo_gCod := StudNo_iCod;
    end;

    procedure SetComment_gFnc(Comment: Text)
    begin
        Comment_gText := Comment;
    end;


    var
        Comment_gText1: Text;


}