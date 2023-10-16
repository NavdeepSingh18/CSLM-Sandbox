table 50363 "Opt Out"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(3; "Application Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Bsic Opt Out,Housing Waiver,Make-Up,Restart,Appeal,Semester Registration,Repeat';
            OptionMembers = "Bsic Opt Out","Housing Wavier","Make-Up","Restart","Appeal","Semester Registration",Repeat;
            trigger OnValidate()
            begin
                IF Rec."Application Type" <> xRec."Application Type" then begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Course Code" := '';
                    "Percentage Obtained" := 0;
                    Grade := '';
                    "Type Of Repeat" := "Type Of Repeat"::" ";
                end;
            end;
        }
        field(10; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
                OLRUpdateLine: Record "OLR Update Line";
                SemesterMaster: Record "Semester Master-CS";
                EducationSetupCS: Record "Education Setup-CS";
                EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
                HousingMailCod: Codeunit "Hosusing Mail";
            begin
                IF "Student No." <> '' then begin
                    StudentMaster_lRec.Reset();
                    If StudentMaster_lRec.Get("Student No.") then begin
                        "Student Name" := Format(StudentMaster_lRec."First Name" + ' ' + StudentMaster_lRec."Middle Name" + ' ' + StudentMaster_lRec."Last Name");
                        "Academic Year" := StudentMaster_lRec."Academic Year";
                        Semester := StudentMaster_lRec.Semester;
                        Term := StudentMaster_lRec.Term;
                        if StudentMaster_lRec."Returning Student" and (not (StudentMaster_lRec."Registrar Signoff")) then begin
                            EducationSetupCS.Reset();
                            EducationSetupCS.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                            EducationSetupCS.SetRange("Pre Housing App. Allowed", false);
                            if EducationSetupCS.FindFirst() then begin
                                OLRUpdateLine.Reset();
                                OLRUpdateLine.SetRange("Student No.", StudentMaster_lRec."No.");
                                OLRUpdateLine.SetRange("OLR Academic Year", EducationSetupCS."Returning OLR Academic Year");
                                OLRUpdateLine.SetRange("OLR Term", EducationSetupCS."Returning OLR Term");
                                OLRUpdateLine.SetRange(Confirmed, true);
                                OLRUpdateLine.FindFirst();
                                "Academic Year" := OLRUpdateLine."OLR Academic Year";
                                Term := OLRUpdateLine."OLR Term";
                                Semester := OLRUpdateLine."OLR Semester";
                            end;
                        end;
                        "Enrolment No." := StudentMaster_lRec."Enrollment No.";
                        "Course Code" := StudentMaster_lRec."Course Code";
                        "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                        IF ("Application Type" = "Application Type"::Appeal) OR ("Application Type" = "Application Type"::"Repeat") then begin
                            GradeBook.Reset();
                            GradeBook.SetRange("Student No.", StudentMaster_lRec."No.");
                            GradeBook.SetRange(Semester, StudentMaster_lRec.Semester);
                            GradeBook.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                            GradeBook.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                            GradeBook.SetRange("Type of Input", GradeBook."Type of Input"::Best);
                            If GradeBook.FindLast() Then begin
                                "Percentage Obtained" := GradeBook."Earned Points Percentage";
                                Grade := GradeBook."Grade Result";
                            end;
                            SemesterMaster.Reset();
                            SemesterMaster.SetRange(Code, StudentMaster_lRec.Semester);
                            IF SemesterMaster.FindFirst() then
                                "Type Of Repeat" := SemesterMaster."Type Of Repeat";

                        End;
                    End;
                End;
                IF "Student No." = '' then begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Course Code" := '';
                    "Percentage Obtained" := 0;
                    Grade := '';
                    "Type Of Repeat" := "Type Of Repeat"::" ";
                end;

                // RecOptOut.Reset();
                // RecOptOut.SetRange("Student No.", "Student No.");
                // RecOptOut.SetRange("Academic Year", "Academic Year");
                // RecOptOut.SetRange(Semester, Semester);
                // RecOptOut.Setrange("Application Type", "Application Type");
                // IF RecOptOut.FindFirst() then
                //     Error('Stduent already exists');



                if "Application Type" = "Application Type"::"Semester Registration" then begin
                    EducationSetupCS.RESET();
                    EducationSetupCS.SETRANGE("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    IF EducationSetupCS.FINDFIRST() THEN
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                            EducationMultiEventCalCS.RESET();
                            EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                            EducationMultiEventCalCS.SETRANGE("Academic Year", StudentMaster_lRec."Academic Year");
                            IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                                "Semester Start Date" := EducationMultiEventCalCS."Start Date";
                                "Semester End Date" := EducationMultiEventCalCS."Revised End Date";
                            END;
                        END ELSE
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                EducationMultiEventCalCS.RESET();
                                EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                                EducationMultiEventCalCS.SETRANGE("Academic Year", StudentMaster_lRec."Academic Year");
                                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                                    "Semester Start Date" := EducationMultiEventCalCS."Start Date";
                                    "Semester End Date" := EducationMultiEventCalCS."Revised End Date";
                                END;
                            END;
                end;
                // if ("Application Type" = "Application Type"::"Housing Wavier") and ("Entry From Portal" = false)
                // and ("Student No." <> '') then
                //     HousingMailCod.MailSendforHousingWaiverSubmit("Student No.", "Application No.");
                //HousingMailCod.CheckHousingApplication(Rec);
            end;

        }
        field(11; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(12; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(13; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
            Editable = False;
            // Trigger OnValidate()
            // begin
            //     HousingMail_gCU.CheckHousingApplication(Rec);
            // end;
        }
        field(14; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
            Editable = False;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = False;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 05-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = False;
        }

        field(18; "Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter(" "));
            trigger OnValidate()
            var
                ReasonCode_lRec: Record "Reason Code";
            begin
                IF Reason <> '' then Begin
                    ReasonCode_lRec.Reset();
                    If ReasonCode_lRec.Get(Reason) then BEGIN
                        IF ReasonCode_lRec.Type = ReasonCode_lRec.Type::" " then
                            "Reason Description" := ReasonCode_lRec.Description;
                    END;
                End ELSE
                    "Reason Description" := '';
            end;
        }
        field(19; "Reason Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected,Submit;
            OptionCaption = 'Open,"Pending for Approval",Approved,Rejected,Submit';
        }
        field(21; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(25; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(26; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Percentage Obtained"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Obtained';
            Editable = False;
        }
        field(37; "Grade"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
            Editable = False;
        }
        field(38; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(39; "Subject 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            VAR
                RecSLOA: Record "Student Leave of Absence";
            begin
                IF "Subject 1" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 1") then
                        "Subject Description 1" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 1" = '' then
                        "Subject Description 1" := '';
                if "Application Type" = "Application Type"::"Make-Up" then begin
                    IF RecSLOA.Get("Application No.") then
                        Error('Already Applied %1', RecSLOA."Application No.");
                end;

            end;
        }
        field(40; "Subject 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 2" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 2") then
                        "Subject Description 2" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 2" = '' then
                        "Subject Description 2" := '';
                if "Application Type" = "Application Type"::"Make-Up" then begin
                    TestField("Subject 1", '');
                    TestField("Subject 3", '');
                    TestField("Subject 4", '');
                    TestField("Subject 5", '');
                end;
            end;
        }
        field(41; "Subject 3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 3" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 3") then
                        "Subject Description 3" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 3" = '' then
                        "Subject Description 3" := '';
                if "Application Type" = "Application Type"::"Make-Up" then begin
                    TestField("Subject 1", '');
                    TestField("Subject 2", '');
                    TestField("Subject 4", '');
                    TestField("Subject 5", '');
                end;
            end;
        }
        field(42; "Subject 4"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 4" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 4") then
                        "Subject Description 4" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 4" = '' then
                        "Subject Description 4" := '';
                if "Application Type" = "Application Type"::"Make-Up" then begin
                    TestField("Subject 1", '');
                    TestField("Subject 2", '');
                    TestField("Subject 3", '');
                    TestField("Subject 5", '');
                end;
            end;
        }
        field(43; "Subject 5"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Subject Master-CS";
            trigger Onvalidate()
            begin
                IF "Subject 5" <> '' then begin
                    SubjectMaster_lRec.Reset();
                    If SubjectMaster_lRec.Get("Subject 5") then
                        "Subject Description 5" := SubjectMaster_lRec."Description";
                END else
                    IF "Subject 5" = '' then
                        "Subject Description 5" := '';
                if "Application Type" = "Application Type"::"Make-Up" then begin
                    TestField("Subject 1", '');
                    TestField("Subject 2", '');
                    TestField("Subject 3", '');
                    TestField("Subject 4", '');
                end;
            end;
        }
        field(44; "Subject Description 1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(45; "Subject Description 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(46; "Subject Description 3"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(47; "Subject Description 4"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(48; "Subject Description 5"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(49; "Approved Condition Failed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "ELOA/SLOA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Student Leave of Absence"."Application No." where(Status = filter(Approved));
            trigger OnValidate()
            var
                SLOA: record "Student Leave of Absence";
            begin
                SLOA.Get("Application No.");
                IF SLOA."Leave Types" = SLOA."Leave Types"::CLOA then
                    Error('Leave Apllication No. must be ELOA/SLOA');
            end;
        }
        field(51; "Exam Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Type Of Repeat"; Option)
        {
            Caption = 'Type Of Repeat';
            OptionMembers = " ","Semester","Year";
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(54; "Application Used"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Present Address1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Trigger Onvalidate()
            Var
                HousingApplication_lRec: Record "Housing Application";
                SLcMToSalesForce_lCU: Codeunit SLcMToSalesforce;
            Begin

                // If Rec."Present Address1" <> xRec."Present Address1" then
                //     SLcMToSalesForce_lCU.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
            End;
        }
        field(56; "Present Address2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Present Address3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Lease Agreement/Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Lease Agreement Group"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Transportation; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Transport Cell"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Semester Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Semester Start Date';
            Editable = false;
        }
        field(63; "Semester End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Semester End Date';
            Editable = false;
        }
        field(64; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            // TableRelation = if (country = const()) "Post Code"
            // else
            // if (Country = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field(Country));
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         Validate(Country, PostCodeRec."Country/Region Code");
            //         Validate(city, PostCodeRec.City);
            //         Validate(County, PostCodeRec.County);
            //     END ELSE BEGIN
            //         Country := '';
            //         city := '';
            //         County := '';
            //     END;
            // end;
        }
        Field(65; "City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
            // TableRelation = if (country = const()) "Post Code".City
            // else
            // if (Country = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = field(Country));

            // trigger OnValidate()
            // var
            //     HousingApplication_lRec: Record "Housing Application";
            //     SLcMToSalesForce_lCU: Codeunit SLcMToSalesforce;
            // Begin

            //     // If Rec.City <> xRec.City then
            //     //     SLcMToSalesForce_lCU.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
            // End;
        }
        Field(66; "Country"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "Country/Region";
            trigger OnValidate()
            var
                HousingApplication_lRec: Record "Housing Application";
                SLcMToSalesForce_lCU: Codeunit SLcMToSalesforce;
            Begin

                // If Rec.Country <> xRec.Country then
                //     SLcMToSalesForce_lCU.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
            End;
        }
        field(67; County; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                HousingApplication_lRec: Record "Housing Application";
                SLcMToSalesForce_lCU: Codeunit SLcMToSalesforce;
            begin
                PostCodeRec.RESET();
                PostCodeRec.FINDSET();
                IF PAGE.RUNMODAL(Page::"Post Codes", PostCodeRec) = ACTION::LookupOK THEN
                    County := FORMAT(PostCodeRec.County);

                // If Rec.County <> xRec.County then
                //     SLcMToSalesForce_lCU.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);

            end;
        }
        Field(68; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry From Portal';
        }
        field(69; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
            // Trigger OnValidate()
            // begin
            //     HousingMail_gCU.CheckHousingApplication(Rec);
            // end;
        }
        field(70; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(72; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }


    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(Key2; "Created On")
        {

        }

    }


    trigger OnInsert()
    VAR
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
        HousingApplication_lRec: Record "Housing Application";
        SLcmToSalesForceCU: Codeunit SLcMToSalesforce;

    begin
        IF "Application No." = '' then begin
            IF "Application Type" = "Application Type"::"Bsic Opt Out" THEN Begin
                UserSetupRec.get(UserId());
                EducationSetup_lRec.Reset();
                EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_lRec.FindFirst() then begin
                    EducationSetup_lRec.TestField("Exam Opt Out No.");
                    NoSeriesMgmt_lCU.InitSeries(EducationSetup_lRec."Exam Opt Out No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            end;
            IF "Application Type" = "Application Type"::"Housing Wavier" THEN Begin
                // UserSetupRec.get(UserId());
                // EducationSetup_lRec.Reset();
                // EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if GlSetup.get() then begin
                    GlSetup.TestField("Housing Opt Out No.");
                    NoSeriesMgmt_lCU.InitSeries(GlSetup."Housing Opt Out No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            end;
            IF "Application Type" = "Application Type"::"Make-Up" THEN Begin
                UserSetupRec.get(UserId());
                EducationSetup_lRec.Reset();
                EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_lRec.FindFirst() then begin
                    EducationSetup_lRec.TestField("MakeUp Exam No.");
                    NoSeriesMgmt_lCU.InitSeries(EducationSetup_lRec."MakeUp Exam No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            End;
            IF "Application Type" = "Application Type"::Restart THEN Begin
                UserSetupRec.get(UserId());
                EducationSetup_lRec.Reset();
                EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_lRec.FindFirst() then begin
                    EducationSetup_lRec.TestField("Restart Application");
                    NoSeriesMgmt_lCU.InitSeries(EducationSetup_lRec."Restart Application", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            End;
            IF "Application Type" = "Application Type"::Appeal THEN Begin
                UserSetupRec.get(UserId());
                EducationSetup_lRec.Reset();
                EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_lRec.FindFirst() then begin
                    EducationSetup_lRec.TestField("Appeal Application");
                    NoSeriesMgmt_lCU.InitSeries(EducationSetup_lRec."Appeal Application", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            End;
            IF "Application Type" = "Application Type"::"Semester Registration" THEN Begin
                UserSetupRec.get(UserId());
                EducationSetup_lRec.Reset();
                EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_lRec.FindFirst() then begin
                    EducationSetup_lRec.TestField("Semester Regstration No.");
                    NoSeriesMgmt_lCU.InitSeries(EducationSetup_lRec."Semester Regstration No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
                end;
            End;
        end;
        if "Global Dimension 1 Code" = '' then
            "Global Dimension 1 Code" := UserSetupRec."Global Dimension 1 Code";
        "Application Date" := WorkDate();
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
        Inserted := True;

        If "Entry From Salesforce" then begin
            // HousingWaiverApprovalMail();
            //SalesForceCodeunit.HousingAllomentInformationSFInsert(Rec, HousingApplication_lRec, 1);
            // SalesForceCodeunit.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);

        end;
        // if not "Entry From Salesforce" then
        //     SalesForceCodeunit.HousingWaiverAndApplicationAPI(HousingApplication_lRec, Rec, 1);
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;

    procedure AssistEdit(OldAcademicBSICoptOut: Record "Opt Out"): Boolean
    var
        AcademicBSICoptOut_lRec: Record "Opt Out";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with AcademicBSICoptOut_lRec do begin
            AcademicBSICoptOut_lRec := Rec;
            UserSetupRec.get(UserId());

            if GlSetup.get() then begin
                GlSetup.TestField("Housing Opt Out No.");
                if NoSeriesMgt.SelectSeries(GlSetup."Housing Opt Out No.", OldAcademicBSICoptOut."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := AcademicBSICoptOut_lRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AssistEdit1(OldAcademicMakeUp: Record "Opt Out"): Boolean
    var
        AcademicMakeUp_lRec: Record "Opt Out";

        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with AcademicMakeUp_lRec do begin
            AcademicMakeUp_lRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("MakeUp Exam No.");
                if NoSeriesMgt.SelectSeries(EducationSetup_lRec."MakeUp Exam No.", OldAcademicMakeUp."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := AcademicMakeUp_lRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AssistEdit2(OldAcademicExamOut: Record "Opt Out"): Boolean
    var
        AcademicMakeUp_lRec: Record "Opt Out";

        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with AcademicMakeUp_lRec do begin
            AcademicMakeUp_lRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("Exam Opt Out No.");
                if NoSeriesMgt.SelectSeries(EducationSetup_lRec."Exam Opt Out No.", OldAcademicExamOut."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := AcademicMakeUp_lRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AssistEdit3(OldAcademicRepeat: Record "Opt Out"): Boolean
    var
        AcademicMakeUp_lRec: Record "Opt Out";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with AcademicMakeUp_lRec do begin
            AcademicMakeUp_lRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("Restart Application");
                if NoSeriesMgt.SelectSeries(EducationSetup_lRec."Restart Application", OldAcademicRepeat."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := AcademicMakeUp_lRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AssistEdit4(OldAcademicAppeal: Record "Opt Out"): Boolean
    var
        AcademicMakeUp_lRec: Record "Opt Out";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with AcademicMakeUp_lRec do begin
            AcademicMakeUp_lRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("Appeal Application");
                if NoSeriesMgt.SelectSeries(EducationSetup_lRec."Appeal Application", OldAcademicAppeal."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := AcademicMakeUp_lRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AssistEdit5(OldAcademicSemesterRegistration: Record "Opt Out"): Boolean
    var
        SemesterRegstrationRec: Record "Opt Out";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with SemesterRegstrationRec do begin
            SemesterRegstrationRec := Rec;
            UserSetupRec.get(UserId());
            EducationSetup_lRec.Reset();
            EducationSetup_lRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if EducationSetup_lRec.FindFirst() then begin
                EducationSetup_lRec.TestField("Semester Regstration No.");
                if NoSeriesMgt.SelectSeries(EducationSetup_lRec."Semester Regstration No.", OldAcademicSemesterRegistration."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := SemesterRegstrationRec;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure AttemptCheck()
    Var
        CourseRec: Record "Course Master-CS";
        SemesterMaster: Record "Semester Master-CS";
        Attemptuse: Integer;
        TotalAttempt: Integer;
        TotalSemester: Integer;
        CurrentSemester: Integer;
    begin
        GradeBook.Reset();
        GradeBook.SetRange("Student No.", "Student No.");
        GradeBook.SetRange("Type of Input", GradeBook."Type of Input"::Best);
        If GradeBook.FindSet() Then
            AttemptUse := GradeBook.Count;

        CourseRec.Reset();
        CourseRec.SetRange("Code", "Course Code");
        if CourseRec.FindFirst() Then begin
            TotalAttempt := CourseRec."Academic SAP";
            TotalSemester := CourseRec."Number of Semesters";
        end;

        SemesterMaster.Reset();
        SemesterMaster.SetRange("Code", Semester);
        If SemesterMaster.FindSet() Then
            CurrentSemester := SemesterMaster.Sequence;

        IF (TotalAttempt - AttemptUse) <= (TotalSemester - CurrentSemester) then
            Error('All Extra Attempt has been used.');
    end;

    // procedure HousingWaiverRejectionMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     UserSetupRec.Get(UserID());
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'Housing Waiver Application Rejection');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your Housing Waiver Application' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been' + ' ' + Format(Status)
    //                         + '.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any clarifications, you may contact Residential Services team.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('* Please submit Housing Application from your Student Portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Waiver Application Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Waiver Application', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure HousingWaiverApprovalMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'Housing Waiver Application Approval');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that your Housing Waiver Application' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been' + ' ' + Format(Status)
    //                         + '. ' + ' ' + 'Below are your housing details for this semester:');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Housing Address:' + ' ' + "Present Address1" + ' ' + "Present Address2" + ' ' + "Present Address3");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('City:' + ' ' + City);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Waiver Application Approval', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Waiver', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    var
        CompanyInformationRec: Record "Company Information";
        EducationSetup_lRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        SubjectMaster_lRec: Record "Subject Master-CS";
        PostCodeRec: Record "Post Code";
        GradeBook: Record "Grade Book";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        SalesForceCodeunit: Codeunit SLcMToSalesforce;
        HousingMail_gCU: Codeunit "Hosusing Mail";
        BodyText: text[2048];


}