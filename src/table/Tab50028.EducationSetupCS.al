table 50028 "Education Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    04-05-2019    OnInsert                User Id Assign in User Id Field.
    // 1         CSPL-00092    04-05-2019    OnModify                Assign Value in Updated Field
    // 2         CSPL-00307    12-10-2021    New Field               Field ID 50154 Request No. Series for Appeal Form Process.
    // 3         CSPL-00307    16-10-2021    New Field               Field ID 50155 (Graduation Date Nos) No. Series for Graduation Date Setup.
    // 4         CSPL-00307    17-11-2021    New Field               Field ID 50156 (SAP Review Nos) No. Series for SAP Review Entries.
    Caption = 'Education Setup';
    DataClassification = CustomerContent;
    DrillDownPageID = "Education Setup-CS";
    LookupPageID = "Education Setup-CS";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(3; "Rank Generation No."; Code[20])
        {
            //CSPL-00307 - Insurance Waiver
            Caption = 'Insurance Waiver No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; Company; Option)
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
            OptionCaption = ' ,School,College';
            OptionMembers = " ",School,College;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(7; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(8; "Announcement No."; Code[20])
        {
            Caption = 'Announcement No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(9; "Image File Path"; Text[250])
        {
            Caption = 'Image File Path';
            DataClassification = CustomerContent;
        }
        field(10; "XML File Path"; Text[250])
        {
            Caption = 'XML File Path';
            DataClassification = CustomerContent;
        }
        field(11; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(12; "Promotion No."; Code[20])
        {
            Caption = 'Promotion No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Attachment File Path"; Text[250])
        {
            Caption = 'Attacment File Path';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50004; "Even/Odd Semester"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: Start
                IF Rec."Even/Odd Semester" <> xRec."Even/Odd Semester" THEN
                    IF NOT CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                        Rec."Even/Odd Semester" := xRec."Even/Odd Semester";
                        Rec.Modify();
                    END ELSE BEGIN
                        Rec.Promoted := FALSE;
                        Rec."Internal Exam Generated" := FALSE;
                        Rec."Assignment  Generated" := FALSE;
                        Rec."Exam Schedule Generated" := FALSE;
                        Rec."External Exam Generated" := FALSE;
                        Rec."End Semester Marks Published" := FALSE;
                        Rec."Grade Generated" := FALSE;
                        Rec."Regular Exam Grade Alloted" := FALSE;
                        Rec."Regular Exam Grade Published" := FALSE;
                        Rec."Makeup Exam Grade Alloted" := FALSE;
                        Rec."Makeup Exam Grade Published" := FALSE;
                        Rec."Rev. 1 Exam Grade Alloted" := FALSE;
                        Rec."Rev. 1  Exam Grade Published" := FALSE;
                        Rec."Special Exam Grade Alloted" := FALSE;
                        Rec."Special Exam Grade published" := FALSE;
                        Rec."Rev. 2  Exam Grade Published" := FALSE;
                    END;

                //Code added for Assign Value in Fields::CSPL-00092::04-05-2019: Start
            end;
        }
        field(50005; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50006; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Course Master-CS";
        }
        field(50007; "Class Attendance Days"; Integer)
        {
            Caption = 'Class Attendance Days';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50008; "Internal Marks Days"; Integer)
        {
            Caption = 'Internal Marks Days';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50009; "External Marks Days"; Integer)
        {
            Caption = 'External Marks Days';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50010; "Min. External Exam Attd. Per."; Decimal)
        {
            Caption = 'Min. External Exam Attd. Per.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50011; "Min. Lab Attd. Per."; Decimal)
        {
            Caption = 'Min. Lab Attd. Per.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50012; "Visible Stud. Time Table"; Integer)
        {
            Caption = 'Visible Stud. Time Table';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50013; "Absent Mail Days"; Integer)
        {
            Caption = 'Absent Mail Days';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50014; "Minimum Number of Electives"; Integer)
        {
            Caption = 'Minimum Number of Electives';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50015; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50016; "Internal Exam Generated"; Boolean)
        {
            Caption = 'Internal Exam Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50017; "Assignment  Generated"; Boolean)
        {
            Caption = 'Assignment  Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50018; "Exam Schedule Generated"; Boolean)
        {
            Caption = 'Exam Schedule Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50019; "External Exam Generated"; Boolean)
        {
            Caption = 'xternal Exam Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50020; "End Semester Marks Published"; Boolean)
        {
            Caption = 'End Semester Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50021; "Grade Generated"; Boolean)
        {
            Caption = 'Grade Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50022; "Regular Exam Grade Alloted"; Boolean)
        {
            Caption = 'Regular Exam Grade Alloted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = true;
        }
        field(50023; "Regular Exam Grade Published"; Boolean)
        {
            Caption = 'Regular Exam Grade Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = true;
        }
        field(50024; "Makeup Exam Grade Alloted"; Boolean)
        {
            Caption = 'Makeup Exam Grade Alloted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50025; "Makeup Exam Grade Published"; Boolean)
        {
            Caption = 'Makeup Exam Grade Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50026; "Rev. 1 Exam Grade Alloted"; Boolean)
        {
            Caption = 'Rev. 1 Exam Grade Alloted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50027; "Rev. 1  Exam Grade Published"; Boolean)
        {
            Caption = 'Rev. 1  Exam Grade Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50028; "Special Exam Grade Alloted"; Boolean)
        {
            Caption = 'Special Exam Grade Alloted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50029; "Special Exam Grade published"; Boolean)
        {
            Caption = 'Special Exam Grade published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50030; "Rev. 2  Exam Grade Alloted"; Boolean)
        {
            Caption = 'Rev. 2  Exam Grade Alloted';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50031; "Rev. 2  Exam Grade Published"; Boolean)
        {
            Caption = 'Rev. 2  Exam Grade Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50032; "GPA & CGPA Generated"; Boolean)
        {
            Caption = 'GPA & CGPA Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50033; "MakeUp Exam Schedule Generated"; Boolean)
        {
            Caption = 'MakeUp Exam Schedule Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50034; "MakeUp External Exam Generated"; Boolean)
        {
            Caption = 'MakeUp External Exam Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50035; "Students Attendance Updated"; Boolean)
        {
            Caption = 'Students Attendance Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50036; "Internal Marks Published"; Boolean)
        {
            Caption = 'Internal Marks Published';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50037; "Special Exam Sche. Generated"; Boolean)
        {
            Caption = 'Special Exam Sche. Generated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            Editable = false;
        }
        field(50038; "Update Detained List"; Boolean)
        {
            Caption = 'Update Detained List';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50039; "Same Session"; Boolean)
        {
            Caption = 'Same Session';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50040; "Detainee List Prepaired"; Boolean)
        {
            Caption = 'Detainee List Prepaired';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }

        field(50042; "Parking BSIC No."; Code[20])
        {
            Caption = 'Parking BSIC No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50043; "Parking AICASA/AUA No."; Code[20])
        {
            Caption = 'Parking AICASA/AUA No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50044; "Housing Mail Terms"; DateFormula)
        {
            Caption = 'Housing Mail Terms';
            DataClassification = CustomerContent;
        }
        field(50045; "Housing Parking No."; Code[20])
        {
            Caption = 'Housing Parking No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50046; "Financial Accountability No."; Code[20])
        {
            Caption = 'Financial Accountability No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50047; "Logo Image"; Blob)
        {
            Caption = 'Logo Image';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;

        }
        field(50048; "Housing Opt Out No."; Code[20])
        {
            Caption = 'Housing Opt Out No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50049; "Minimum Clinical Weeks Allowed"; Integer)
        {
            Caption = 'Minimum Clinical Weeks Allowed';
            DataClassification = CustomerContent;
        }
        field(50050; "Maximum Clinical Weeks Allowed"; Integer)
        {
            Caption = 'Maximum Clinical Weeks Allowed';
            DataClassification = CustomerContent;
        }
        field(50051; "Core Clinical Roster Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50052; "Elective Clinical Roster Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50053; "FM1_IM1 Clerkship Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50054; "Clinical SPL Considration Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50055; "Exam SPL Considration Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50056; "MakeUp Exam No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50057; "Exam Opt Out No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50058; "Withdrawal No."; Code[20])
        {
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50059; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50060; "School ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50061; "SLcM Equiry No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50062; "SLcM Test ID Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50063; "Restart Application"; Code[20])
        {
            Caption = 'Repeat Application';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50064; "Appeal Application"; Code[20])
        {
            Caption = 'Appeal Application';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50065; "Registration Email"; DateFormula)
        {
            Caption = 'Registration Email';
            DataClassification = CustomerContent;
        }
        field(50067; "Curriculumn Alert"; Boolean)
        {
            Caption = 'Curriculumn Alert';
            DataClassification = CustomerContent;
        }
        field(50068; "Semester Regstration No."; Code[20])
        {
            Caption = 'Semester Regstration No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50069; "Semester Registration Terms"; DateFormula)
        {
            Caption = 'Semester Registration Terms';
            DataClassification = CustomerContent;
        }
        field(50070; "Certificate Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50071; "Elective Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50072; "Course Withdrawal Applicable"; Boolean)
        {
            Caption = 'Course Withdrawal Applicable';
            DataClassification = CustomerContent;
        }
        field(50073; "Withdrawal Percentage"; Decimal)
        {
            Caption = 'Withdrawal Percentage';
            DataClassification = CustomerContent;
        }

        field(50075; "Withdrawal End Date"; Option)
        {
            caption = 'Withdrawal End Date Calculation';
            OptionCaption = ' ,Attendance Date,Apply Date';
            OptionMembers = " ","Attendance Date","Apply Date";
            DataClassification = CustomerContent;
        }
        field(50076; "Institute Name"; Text[500])
        {
            Caption = 'Institute Name';
            DataClassification = CustomerContent;
        }

        field(50077; "Institute Address"; Text[250])
        {
            Caption = 'Institute Address';
            DataClassification = CustomerContent;
        }
        field(50078; "Institute Address 2"; Text[250])
        {
            Caption = 'Institute Address 2';
            DataClassification = CustomerContent;
        }
        field(50079; "Institute City"; Text[30])
        {
            Caption = 'Institute City';
            // TableRelation = "Post Code".City;
            DataClassification = CustomerContent;

        }
        field(50080; "Institute Country Code"; Code[10])
        {
            Caption = 'Institute Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50081; "Institute Post Code"; Code[20])
        {
            Caption = 'Institute Post Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Institute Country Code" = const()) "Post Code"
            else
            if ("Institute Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Institute Country Code"));
        }
        field(50082; "Institute Phone No."; Text[30])
        {
            Caption = 'Institute Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(50083; "Institute Phone No. 2"; Text[30])
        {
            Caption = 'Institute Phone No. 2';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }

        field(50084; "Institute Fax No."; Text[30])
        {
            Caption = 'Institute Fax No.';
        }
        field(50085; "Institute E-Mail"; Text[80])
        {
            Caption = 'Institute Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Institute E-Mail");
            end;
        }
        field(50086; "Max Days Issue Pending"; Integer)
        {
            Caption = 'Max Days Issue Pending';
        }
        field(50087; "Max Days Issue Accepted"; Integer)
        {
            Caption = 'Max Days Issue Accepted';
        }
        field(50088; "Max Days Issue Resolved"; Integer)
        {
            Caption = 'Max Days Issue Resolved';
        }
        field(50089; "Immigration Document No."; Code[20])
        {
            Caption = 'Immigration Document No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50090; "FM1/IM1 Date Preset Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50091; "Elective Rotation Offer Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50092; "FM1/IM1 Application Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50093; "Non-Affiliated Appl. Nos."; Code[20])
        {
            Caption = 'Non-Affiliated Application Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50094; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "No. series";
        }
        field(50095; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50096; "Leave Of Absence No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Leave Of Absence No.';
            TableRelation = "No. Series";
        }
        field(50097; "Housing Application No."; Code[20])
        {
            Caption = 'Housing Application No.';
            DataClassification = CustomerContent;
            TableRelation = "No. series";
        }
        field(50098; "Housing Change/Vacate No."; Code[20])
        {
            Caption = 'Housing Change/Vacate No.';
            DataClassification = CustomerContent;
            TableRelation = "No. series";
        }
        field(50099; "Enrolment History Nos."; Code[20])
        {
            Caption = 'Enrolment History';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50100; "Clerkship Semester Filter"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50101; "FM1/IM1 Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code;
        }
        field(50102; "Faculty Mapping"; Option)
        {
            caption = 'Faculty Mapping';
            OptionCaption = ' ,Subject Wise,Category Wise';
            OptionMembers = " ","Subject Wise","Category Wise";
            DataClassification = CustomerContent;
        }
        field(50103; "FERPA Info Header No."; Code[20])
        {
            Caption = 'FERPA Info Header No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50104; "FM1/IM1 Semester Filter"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Semester Filter';
        }
        field(50105; "Core Subjects for Elective"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Subjects for Elective';
        }

        field(50106; "Elective Semester Filter"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Rotation Semester Filter';
        }
        field(50107; "USMLE Step 1 Exam Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Step 1 Exam Code';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(true));
            //TestTableRelation = false;
        }

        field(50109; "CBSE Exam Code for FM1/IM1"; Code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'CBSE Exam Code for FM1/IM1';
        }
        field(50110; "E-mail ID (SalesForce Log)"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'E-mail ID (SalesForce Log)';

        }
        field(50115; "Pediatrics Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pediatrics Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50117; "OBG Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Obstetrics/Gynecology Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50119; "Surgery Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Surgery Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50121; "Family Medicine Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Family Medicine Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50123; "Psychiatric Subject Group"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Psychiatric Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50125; "IM Subject Group"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Internal Medicine Subject Group Subject Group';
            TableRelation = "Subject Master-CS".Code where(Examination = filter(false), "Level Description" = filter("Main Subject"));
        }
        field(50126; "Residency Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50127; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50128; "Core Subject Group Code"; Code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Core Subject Group Code';
        }
        field(50129; "Pre Clinical Semesters"; Code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre Clinical Semesters';
        }
        field(50130; "Active Statuses"; Code[800])
        {
            DataClassification = CustomerContent;
            Caption = 'Active Statuses';
        }
        field(50131; "CBSE Certifying Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CBSE Certifying Score';
        }
        field(50132; "USMLE Applicable for FM1/IM1"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Applicable for FM1/IM1';
        }
        field(50133; "Rotation Cancel Appln Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = '"Rotation Cancellation Application Nos.';
            TableRelation = "No. Series";
        }
        field(50134; "OLR Update Application Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50135; "Student Status for Exam"; Code[800])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Status for Exam';
        }
        field(50140; "Clinical Science Logo"; Blob)
        {
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }


        field(50141; "Associate Vice President"; Blob)
        {
            Caption = 'Associate Vice President for Academic Administration';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }
        field(50142; "Collage of Medicine Logo"; Blob)
        {
            Caption = 'Clinical Collage of Medicine Logo';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }
        field(50143; "Returning OLR Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            trigger OnValidate()
            var
                CourseSubjectLine: Record "Course Wise Subject Line-CS";
            Begin
                If "Returning OLR Academic Year" <> '' then begin
                    If xRec."Returning OLR Academic Year" <> Rec."Returning OLR Academic Year" then begin
                        CourseSubjectLine.Reset();
                        CourseSubjectLine.SetRange("Synch to Blackboard", true);
                        CourseSubjectLine.ModifyAll("Blackboard Synch Status", CourseSubjectLine."Blackboard Synch Status"::Pending);
                    end;
                end;
            End;
        }
        field(50144; "Returning OLR Term"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            trigger OnValidate()
            var
                CourseSubjectLine: Record "Course Wise Subject Line-CS";
            Begin

                If xRec."Returning OLR Term" <> Rec."Returning OLR Term" then begin
                    CourseSubjectLine.Reset();
                    CourseSubjectLine.SetRange("Synch to Blackboard", true);
                    CourseSubjectLine.ModifyAll("Blackboard Synch Status", CourseSubjectLine."Blackboard Synch Status"::Pending);
                end;

            End;
        }
        field(50145; "Housing Approval CC E-mail"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(50146; "KK Report Data From Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50147; "Site Visit Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50148; "To Bursar E-mail ID"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        Field(50149; "CC Bursar E-mail ID"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50150; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50151; "Medical Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50152; "Application No For Doc."; code[20])
        {
            Caption = 'Post Graduate Documentation Request Application No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50153; "Application No For Residency."; code[20])
        {
            Caption = 'Residency Placement Result Application No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50154; "Request No Nos"; code[20])
        {
            //// CSPL-00307-For Appeal Form Process
            Caption = 'Request No. Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50155; "Graduation Date Setup Nos"; code[20])
        {
            //// CSPL-00307-For Graduation Date Setup
            Caption = 'Graduation Date Setup Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50156; "SAP Review NOS"; code[20])
        {
            //// CSPL-00307-For Table 50472
            Caption = 'SAP Review NOS';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        Field(50157; "Pre Housing App. Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50158; "Grading Status"; Code[800])
        {
            DataClassification = CustomerContent;
        }
        Field(50159; "Dummy Student Subject"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50160; "ISIR Error(Email ID)"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        Field(50161; "SAP Users Email ID"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        Field(50162; "SFP Disbursment Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        Field(50163; "SFP Disbursment Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("SFP Disbursment Template"));
        }
        Field(50164; "SFP R2T4 Template"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        Field(50165; "SFP R2T4 Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("SFP R2T4 Template"));
        }
        field(50170; "R-Grade Registrar Email"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'R-Grade Registrar Email';
        }
        field(50171; "FM1/IM1 Secondary Subjects"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Secondary Subjects';
        }
        field(50172; "Document Upload Email"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Upload Email';
        }
        field(50173; "CLN Billing Opening Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Billing Opening Date';
        }
        Field(50174; "Booking Setup No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50175; "Status for TWD Automation"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        Field(50176; "Semester Group Mapping No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50177; "User Task No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50178; "TA Timesheet No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        Field(50179; "Per Hrs Cost Setup"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(50180; "Pre-Clinical Cord. Email"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'TA Timesheet Review Team E-Mail ID';
        }
        field(50181; "FA Cordinator Email"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'TA Timesheet Finance Team E-mail ID';
        }
        field(50182; "EED Clinical Faculty Email"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'TA Timesheet EED Clinical Faculty Team E-mail ID';
        }
        field(50183; "Cashnet File No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50184; "Rotation Cancellation Email"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Cancellation Team E-mail ID';
        }
        field(50185; "From Insurance Waiver date"; Date)//GAURAV//27//01//23
        {
            //CSPL-00307 - Insurance Waiver
            DataClassification = CustomerContent;

        }
        field(50186; "To Insurance Waiver Date"; Date)//GAURAV//27//01//23
        {
            //CSPL-00307 - Insurance Waiver
            DataClassification = CustomerContent;

        }
        field(50187; "Dummy No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50188; "Trans No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50189; "Bulk EMail-Id"; code[2048])
        {
            Caption = 'Bulk Email-Id';
            DataClassification = CustomerContent;
        }
        field(50194; "Due Date1"; Date)
        {
            Caption = 'Due Date (MED1)';
            DataClassification = CustomerContent;
        }
        field(50195; "Due Date2"; Date)
        {
            Caption = 'Due Date (MED2, MED3, MED4)';
            DataClassification = CustomerContent;
        }

        field(50196; "Due Date3"; Date)
        {
            Caption = 'Due Date (BSIC)';
            DataClassification = CustomerContent;
        }
        field(50197; "Due Date4"; Date)
        {
            Caption = 'Due Date (PREMED)';
            DataClassification = CustomerContent;
        }
        field(50198; "Insurance Agreement Date"; Date)
        {
            Caption = 'Insurance Agreement Date';
            DataClassification = CustomerContent;
        }
        field(50199; "FAFSA Academic Year"; Text[10])
        {
            Caption = 'FAFSA Academic Year';
            DataClassification = CustomerContent;
        }
        field(50200; "Loan Period Date 1"; Date)
        {
            Caption = 'Loan Period From Date 1';
            DataClassification = CustomerContent;
        }
        field(50201; "Loan Period Date 2"; Date)
        {
            Caption = 'Loan Period To Date 1';
            DataClassification = CustomerContent;
        }
        field(50202; "Loan Period Date 3"; Date)
        {
            DataClassification = Customercontent;
            Caption = 'Loan Period From Date 2';
        }
        field(50203; "Loan Period Date 4"; Date)
        {
            DataClassification = Customercontent;
            Caption = 'Loan Period To Date 2';
        }
        field(50204; "Withdrawal BSIC Email ID"; Text[650])
        {
            DataClassification = CustomerContent;
            Caption = 'Withdrawal BSIC Bulk Email ID';
        }
        field(50205; "Withdrawal CLN Email ID"; Text[650])
        {
            DataClassification = CustomerContent;
            Caption = 'Withdrawal CLN Bulk Email ID';
        }
        field(60000; "Grenville Logo"; Blob)
        {
            Caption = 'Logo Image';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;

        }
        field(60001; "View/Update Doc"; Code[800])
        {
            DataClassification = CustomerContent;
            Caption = 'Active Status (View/Update Doc)';
        }

        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }

        field(33048922; State; text[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048923; url; text[50])
        {
            Caption = 'url';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048924; "domain name"; text[50])
        {
            Caption = 'domain name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048925; "Pell ID"; Code[10])
        {
            Caption = 'Pell ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048926; "loan ID"; Code[10])
        {
            Caption = 'loan ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048927; "TG Number"; Code[10])
        {
            Caption = 'TG Number';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048928; "GL Company Number"; Code[10])
        {
            Caption = 'GL Company Number';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048929; "Block"; Boolean)
        {
            Caption = 'block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048930; "Official School Name"; Text[120])
        {
            Caption = 'Official School Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048931; "DL Rpt Entity ID"; code[10])
        {
            Caption = 'DL Rpt Entity ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
        field(33048932; "DL Att Entity ID"; code[10])
        {
            Caption = 'DL Att Entity ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-12-2021';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
        key(Key2; "Global Dimension 1 Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: Start
        "User ID" := FORMAT(UserId());
        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::04-05-2019: End
    end;

    var
        Text_10001Lbl: Label 'Do You Want To Change Current Session ?';
}

