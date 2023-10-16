report 50161 "Housing Roster"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Housing Roster.rdl';

    dataset
    {
        dataitem("Housing Master"; "Housing Master")
        {
            RequestFilterFields = "Housing Group", "Housing ID";
            column(FilterShow; GETFILTERS())
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup.url)
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            Column(LogoImageAICASA; RecEduSetup1."Logo Image")
            {

            }
            column(Housing_Group; "Housing Group")
            {

            }
            column(Housing_ID; "Housing ID")
            {

            }
            column(Housing_Name; "Housing Name")
            {

            }
            dataitem("Room Master"; "Room Master")
            {
                DataItemLink = "Housing ID" = field("Housing ID");
                DataItemTableView = sorting("Housing ID", "Room No.");
                RequestFilterFields = "Room No.";
                column(Room_Category_Code; "Room Category Code")
                {

                }
                column(Room_No_; "Room No.")
                {

                }
                dataitem("Room Wise Bed"; "Room Wise Bed")
                {
                    DataItemLink = "Housing ID" = field("Housing ID"), "Room No." = field("Room No.");
                    DataItemTableView = sorting("Housing ID", "Room No.", "Bed No.");
                    column(Bed_No_; "Bed No.")
                    {

                    }
                    column(StudentNo; StudentNo)
                    {

                    }
                    column(EnrollmentNo; Enrollment)
                    {

                    }
                    column(FirstName; FirstName)
                    {

                    }
                    column(LastName; LastName)
                    {

                    }
                    column(Semester; Semester)
                    {

                    }
                    column(InstituteCode; InstituteCode)
                    {

                    }
                    column(StudentType; StudentType)
                    {

                    }
                    column(HousingType; HousingType)
                    {

                    }
                    column(Gender; Gender)
                    {

                    }
                    column(Age; Age)
                    {

                    }
                    column(Cost; Cost)
                    {

                    }
                    column(SGS_SGL; SGS_SGL)
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin
                        StudentNo := '';
                        Semester := '';
                        Enrollment := '';
                        FirstName := '';
                        LastName := '';
                        InstituteCode := '';
                        StudentType := '';
                        HousingType := '';
                        Gender := '';
                        Age := 0;
                        Assigned := 0;
                        Cost := 0;
                        SGS_SGL := '';

                        IF "Room Wise Bed".Blocked = false then begin
                            HousingLedger.Reset();
                            HousingLedger.SetRange("Housing ID", "Housing ID");
                            HousingLedger.SetRange("Room No.", "Room No.");
                            HousingLedger.SetRange("Bed No.", "Bed No.");
                            HousingLedger.CalcSums("Room Assignment");
                            Assigned := HousingLedger."Room Assignment";
                            if Assigned <> 0 then begin
                                If HousingLedger.FindLast() then begin

                                    IF (HousingLedger."With Spouse" = true) Then Begin
                                        StudentNo := HousingLedger."Student No.";
                                        If StudentNo <> '' then begin
                                            Studentmaster.Reset();
                                            Studentmaster.SetRange("No.", StudentNo);
                                            If not Studentmaster.FindFirst() then
                                                CurrReport.Skip();
                                            If Studentmaster.FindFirst() then;
                                            CourseMasterRec.Get(Studentmaster."Course Code");
                                            Semester := Studentmaster.Semester;
                                            Enrollment := Studentmaster."Enrollment No.";
                                            FirstName := Studentmaster."First Name";
                                            LastName := Studentmaster."Last Name";
                                            InstituteCode := Studentmaster."Global Dimension 1 Code";
                                            StudentType := Format(CourseMasterRec."Course Category");
                                            HousingType := Format(Studentmaster."Housing Type");
                                            Gender := Format(Studentmaster.Gender);
                                            Age := Studentmaster.Age;

                                            RoomCategoryMaster.Reset();
                                            RoomCategoryMaster.SetRange("Room Category Code", "Room Master"."Room Category Code");
                                            RoomCategoryMaster.SetRange("Housing ID", "Housing ID");
                                            RoomCategoryMaster.SetFilter("Effective From", '<=%1', WorkDate());
                                            if RoomCategoryMaster.FindFirst() then begin
                                                If StudentNo <> StudentNo2 then begin
                                                    Cost := RoomCategoryMaster."With Spouse Cost";
                                                    SGS_SGL := 'SGS';
                                                end Else begin
                                                    Cost := 0;
                                                    SGS_SGL := 'SGS';
                                                end;
                                            end;
                                            StudentNo2 := StudentNo;
                                        end;
                                    End;

                                    IF (HousingLedger."With Spouse" = false) Then Begin
                                        StudentNo := HousingLedger."Student No.";
                                        If StudentNo <> '' then begin
                                            Studentmaster.Reset();
                                            Studentmaster.SetRange("No.", StudentNo);
                                            If not Studentmaster.FindFirst() then
                                                CurrReport.Skip();
                                            If Studentmaster.FindFirst() then;
                                        end;
                                        CourseMasterRec.Get(Studentmaster."Course Code");
                                        Semester := Studentmaster.Semester;
                                        Enrollment := Studentmaster."Enrollment No.";
                                        FirstName := Studentmaster."First Name";
                                        LastName := Studentmaster."Last Name";
                                        InstituteCode := Studentmaster."Global Dimension 1 Code";
                                        StudentType := Format(CourseMasterRec."Course Category");
                                        HousingType := Format(Studentmaster."Housing Type");
                                        Gender := Format(Studentmaster.Gender);
                                        Age := Studentmaster.Age;

                                        RoomCategoryMaster.Reset();
                                        RoomCategoryMaster.SetRange("Room Category Code", "Room Master"."Room Category Code");
                                        RoomCategoryMaster.SetRange("Housing ID", "Housing ID");
                                        RoomCategoryMaster.SetFilter("Effective From", '<=%1', WorkDate());
                                        if RoomCategoryMaster.FindFirst() then begin
                                            Cost := RoomCategoryMaster.Cost;
                                            SGS_SGL := 'SGL';
                                        end;
                                    End;
                                end;
                            End Else begin
                                RoomCategoryMaster.Reset();
                                RoomCategoryMaster.SetRange("Room Category Code", "Room Master"."Room Category Code");
                                RoomCategoryMaster.SetRange("Housing ID", "Housing ID");
                                RoomCategoryMaster.SetFilter("Effective From", '<=%1', WorkDate());
                                if RoomCategoryMaster.FindFirst() then begin
                                    SGS_SGL := 'SGL';
                                    Cost := RoomCategoryMaster.Cost;
                                end;
                            end;
                        end Else begin
                            LastName := 'Blocked';
                            RoomCategoryMaster.Reset();
                            RoomCategoryMaster.SetRange("Room Category Code", "Room Master"."Room Category Code");
                            RoomCategoryMaster.SetRange("Housing ID", "Housing ID");
                            RoomCategoryMaster.SetFilter("Effective From", '<=%1', WorkDate());
                            if RoomCategoryMaster.FindLast() then begin
                                SGS_SGL := 'SGL';
                                Cost := RoomCategoryMaster.Cost;
                            end;
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    StudentNo2 := '';
                end;
            }
        }
    }

    var
        Studentmaster: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
        RoomCategoryMaster: Record "Room Category Fee Setup";
        HousingLedger: Record "Housing Ledger";
        CourseMasterRec: Record "Course Master-CS";
        StudentNo: Code[20];
        StudentNo2: Code[20];
        Semester: Code[20];
        Enrollment: Code[20];
        FirstName: Text[50];
        LastName: Text[50];
        InstituteCode: Code[20];
        StudentType: Text[50];
        HousingType: Text[50];
        Gender: Text[30];
        Age: Integer;
        Cost: Decimal;
        SGS_SGL: Code[20];
        Assigned: Integer;

    trigger OnPreReport()
    begin
        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");

        RecEduSetup1.Reset();
        RecEduSetup1.SetRange("Global Dimension 1 Code", '9100');
        IF RecEduSetup1.FindFirst() then
            RecEduSetup1.CALCFIELDS("Logo Image");
    end;
}