page 50223 "Education Setup-CS"
{
    // version V.001-CS

    UsageCategory = None;
    Caption = 'Education Setup';
    PageType = Card;
    SourceTable = "Education Setup-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditList;
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Key';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Session';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Even/Odd Semester"; Rec."Even/Odd Semester")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                Field("Pre Housing App. Allowed"; Rec."Pre Housing App. Allowed")
                {
                    ApplicationArea = All;
                }
                field("Returning OLR Academic Year"; Rec."Returning OLR Academic Year")
                {
                    ApplicationArea = All;

                }
                field("Returning OLR Term"; Rec."Returning OLR Term")
                {
                    ApplicationArea = All;
                }
                field("Faculty Mapping"; Rec."Faculty Mapping")
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Image File Path"; Rec."Image File Path")
                {
                    ApplicationArea = All;
                }
                field("XML File Path"; Rec."XML File Path")
                {
                    ApplicationArea = All;
                }
                field("Class Attendance Days"; Rec."Class Attendance Days")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks Days"; Rec."Internal Marks Days")
                {
                    ApplicationArea = All;
                }
                field("External Marks Days"; Rec."External Marks Days")
                {
                    ApplicationArea = All;
                }

                field("Semester Registration Terms"; Rec."Semester Registration Terms")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal End Date"; Rec."Withdrawal End Date")
                {
                    ApplicationArea = All;
                }
                field("Max Days Issue Pending"; Rec."Max Days Issue Pending")
                {
                    ApplicationArea = All;
                }
                field("Max Days Issue Accepted"; Rec."Max Days Issue Accepted")
                {
                    ApplicationArea = All;
                }
                field("Max Days Issue Resolved"; Rec."Max Days Issue Resolved")
                {
                    ApplicationArea = All;
                }
                field("Immigration Document No."; Rec."Immigration Document No.")
                {
                    ApplicationArea = All;
                }
                /*
                field("Degree Audit Document No."; Rec."Degree Audit Document No.")
                {
                    ApplicationArea = All;
                }
                */
                field(url; Rec.url)
                {
                    ApplicationArea = All;
                }
                field("domain name"; Rec."domain name")
                {
                    ApplicationArea = All;
                }
                field("Pell ID"; Rec."Pell ID")
                {
                    ApplicationArea = All;
                }
                field("loan ID"; Rec."loan ID")
                {
                    ApplicationArea = All;
                }
                field("TG Number"; Rec."TG Number")
                {
                    ApplicationArea = All;
                }
                field("GL Company Number"; Rec."GL Company Number")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Official School Name"; Rec."Official School Name")
                {
                    ApplicationArea = All;
                }
                field("DL Rpt Entity ID"; Rec."DL Rpt Entity ID")
                {
                    ApplicationArea = All;
                }
                field("DL Att Entity ID"; Rec."DL Att Entity ID")
                {
                    ApplicationArea = All;
                }


                field("KK Report Data From Date"; Rec."KK Report Data From Date")
                {
                    ApplicationArea = all;
                }
                Field("To Bursar E-mail ID"; Rec."To Bursar E-mail ID")
                {
                    ApplicationArea = All;
                }
                Field("CC Bursar E-mail ID"; Rec."CC Bursar E-mail ID")
                {
                    ApplicationArea = All;
                }
                field("SAP Users Email ID"; Rec."SAP Users Email ID")
                {
                    ToolTip = 'Specifies the value of the SAP Users Email ID field.';
                    ApplicationArea = All;
                }
                field("Document Upload Email"; Rec."Document Upload Email")
                {
                    ToolTip = 'Specifies the value of the Document Upload Email field.';
                    ApplicationArea = All;
                }
                field("SFP Disbursment Template"; Rec."SFP Disbursment Template")
                {
                    ToolTip = 'Specifies the value of the SFP Disbursment Template field.';
                    ApplicationArea = All;
                }
                field("SFP Disbursment Batch"; Rec."SFP Disbursment Batch")
                {
                    ToolTip = 'Specifies the value of the SFP Disbursment Batch field.';
                    ApplicationArea = All;
                }
                field("SFP R2T4 Template"; Rec."SFP R2T4 Template")
                {
                    ToolTip = 'Specifies the value of the SFP R2T4 Template field.';
                    ApplicationArea = All;
                }
                field("SFP R2T4 Batch"; Rec."SFP R2T4 Batch")
                {
                    ToolTip = 'Specifies the value of the SFP R2T4 Batch field.';
                    ApplicationArea = All;
                }
                field("From Insurance Waiver date"; Rec."From Insurance Waiver date")//GAURAV//27//01//23
                {
                    //CSPL-00307 - Insurance Waiver
                    ApplicationArea = All;
                }
                field("To Insurance Waiver Date"; Rec."To Insurance Waiver Date")//GAURAV//27//01//23
                {
                    //CSPL-00307 - Insurance Waiver
                    ApplicationArea = All;
                }
                Field("Bulk EMail-Id"; Rec."Bulk EMail-Id")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
            group("Institute Details")
            {
                Editable = EditList;
                field("Institute Name"; Rec."Institute Name")
                {
                    ApplicationArea = All;
                }
                field("Institute Address"; Rec."Institute Address")
                {
                    ApplicationArea = All;
                }
                field("Institute Address 2"; Rec."Institute Address 2")
                {
                    ApplicationArea = All;
                }
                field("Institute Country Code"; Rec."Institute Country Code")
                {
                    ApplicationArea = All;
                }
                field("Institute City"; Rec."Institute City")
                {
                    ApplicationArea = All;
                }
                field("Institute Post Code"; Rec."Institute Post Code")
                {
                    ApplicationArea = All;
                }
                field("Institute Phone No."; Rec."Institute Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Institute Phone No. 2"; Rec."Institute Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("Institute E-Mail"; Rec."Institute E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Institute Fax No."; Rec."Institute Fax No.")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                }
                field("Housing Approval CC E-mail"; Rec."Housing Approval CC E-mail")
                {
                    ApplicationArea = all;
                }
                Field("ISIR Error(Email ID)"; Rec."ISIR Error(Email ID)")
                {
                    ApplicationArea = all;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                Editable = EditList;
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
                field("Leave Of Absence No."; Rec."Leave Of Absence No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Application No."; Rec."Housing Application No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Change/Vacate No."; Rec."Housing Change/Vacate No.")
                {
                    ApplicationArea = All;
                }
                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                }
                field("Announcement No."; Rec."Announcement No.")
                {
                    ApplicationArea = All;
                }
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Mail Terms"; Rec."Housing Mail Terms")
                {
                    ApplicationArea = All;
                }
                field("Logo Image"; Rec."Logo Image")
                {
                    ApplicationArea = All;
                }
                Field("Semester Regstration No."; Rec."Semester Regstration No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Opt Out No."; Rec."Housing Opt Out No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Parking No."; Rec."Housing Parking No.")
                {
                    ApplicationArea = All;
                }

                field("Residency Nos."; Rec."Residency Nos.")
                {
                    ApplicationArea = All;
                }
                field("Parking AICASA/AUA No."; Rec."Parking AICASA/AUA No.")
                {
                    ApplicationArea = All;
                }
                field("Parking BSIC No."; Rec."Parking BSIC No.")
                {
                    ApplicationArea = All;
                }
                field("Financial Accountability No."; Rec."Financial Accountability No.")
                {
                    ApplicationArea = All;
                }
                field("MakeUp Exam No."; Rec."MakeUp Exam No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Opt Out No."; Rec."Exam Opt Out No.")
                {
                    ApplicationArea = All;
                }

                field("Withdrawal No."; Rec."Withdrawal No.")
                {
                    ApplicationArea = All;
                }
                field("Promotion No."; Rec."Promotion No.")
                {
                    ApplicationArea = All;
                }
                field("Repeat Application"; Rec."Restart Application")
                {
                    ApplicationArea = All;
                }
                field("Appeal Application"; Rec."Appeal Application")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment History Nos."; Rec."Enrolment History Nos.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Restart Application Nos."; Rec."Restart Application")

                {
                    ApplicationArea = All;
                }
                field("Registration Email"; Rec."Registration Email")
                {
                    ApplicationArea = All;
                }
                field("Curriculumn Alert"; Rec."Curriculumn Alert")
                {
                    ApplicationArea = All;
                }
                field("Certificate Application No."; Rec."Certificate Application No.")
                {
                    ApplicationArea = All;
                }

                Field("Withdrawal Percentage"; Rec."Withdrawal Percentage")
                {
                    ApplicationArea = All;
                }
                field("School ID"; Rec."School ID")
                {
                    ApplicationArea = all;
                }
                field("SLcM Equiry No."; Rec."SLcM Equiry No.")
                {
                    ApplicationArea = all;
                }
                field("SLcM Test ID Nos."; Rec."SLcM Test ID Nos.")
                {
                    ApplicationArea = all;
                }
                field("FERPA Info Header No."; Rec."FERPA Info Header No.")
                {
                    ApplicationArea = all;
                }
                field("OLR Update Application Nos."; Rec."OLR Update Application Nos.")
                {
                    ApplicationArea = All;
                }
                Field("Site Visit Nos"; Rec."Site Visit Nos")
                {
                    ApplicationArea = All;
                }
                Field("Graduation Date Setup Nos"; Rec."Graduation Date Setup Nos")
                {
                    ApplicationArea = All;
                }
                field("SAP Review NOS"; Rec."SAP Review NOS")
                {
                    ApplicationArea = All;
                }
                Field("Dummy Student Subject"; Rec."Dummy Student Subject")
                {
                    ApplicationArea = All;
                }
                field("Medical Nos."; Rec."Medical Nos.")
                {
                    Caption = 'Medical Scholar Nos';
                    ToolTip = 'Specifies the value of the Medical Nos. field.';
                    ApplicationArea = All;
                }
                field("Cashnet File No."; Rec."Cashnet File No.")
                {
                    ApplicationArea = All;
                }
                field("Rank Generation No."; Rec."Rank Generation No.")
                {   //CSPL-00307 - Insurance Waiver
                    ApplicationArea = All;
                }
                field("Trans No."; Rec."Trans No.")
                {
                    ApplicationArea = All;
                }
                field("User Task No."; Rec."User Task No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Clinical Clerkship")
            {
                Editable = EditList;
                field("FM1/IM1 Subject Code"; Rec."FM1/IM1 Subject Code")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Secondary Subjects"; Rec."FM1/IM1 Secondary Subjects")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Semester Filter"; Rec."FM1/IM1 Semester Filter")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Date Preset Nos."; Rec."FM1/IM1 Date Preset Nos.")
                {
                    ApplicationArea = all;
                }
                field("FM1/IM1 Application Nos."; Rec."FM1/IM1 Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("FM1_IM1 Clerkship Nos."; Rec."FM1_IM1 Clerkship Nos.")
                {
                    ApplicationArea = all;
                }
                field("USMLE Step 1 Exam Code"; Rec."USMLE Step 1 Exam Code")
                {
                    ApplicationArea = all;
                }
                field("USMLE Applicable for FM1/IM1"; Rec."USMLE Applicable for FM1/IM1")
                {
                    ApplicationArea = All;
                }
                field("CBSE Exam Code for FM1/IM1"; Rec."CBSE Exam Code for FM1/IM1")
                {
                    ApplicationArea = all;
                }
                field("CBSE Certifying Score"; Rec."CBSE Certifying Score")
                {
                    ApplicationArea = all;
                }
                field("Clerkship Semester Filter"; Rec."Clerkship Semester Filter")
                {
                    ApplicationArea = All;
                }
                field("Core Clinical Roster Nos."; Rec."Core Clinical Roster Nos.")
                {
                    ApplicationArea = all;
                }
                field("Elective Semester Filter"; Rec."Elective Semester Filter")
                {
                    ApplicationArea = all;
                }
                field("Minimum Clinical Weeks Allowed"; Rec."Minimum Clinical Weeks Allowed")
                {
                    ApplicationArea = all;
                }
                field("Maximum Clinical Weeks Allowed"; Rec."Maximum Clinical Weeks Allowed")
                {
                    ApplicationArea = all;
                }
                field("Core Subject Group Code"; Rec."Core Subject Group Code")
                {
                    ApplicationArea = All;
                }
                field("Core Subjects for Elective"; Rec."Core Subjects for Elective")
                {
                    ApplicationArea = All;
                }
                field("Elective Rotation Offer Nos"; Rec."Elective Rotation Offer Nos")
                {
                    ApplicationArea = all;
                }
                field("Elective Application No."; Rec."Elective Application No.")
                {
                    ApplicationArea = all;
                }
                field("Elective Clinical Roster Nos."; Rec."Elective Clinical Roster Nos.")
                {
                    ApplicationArea = all;
                }
                field("Non-Affiliated Appl. Nos."; Rec."Non-Affiliated Appl. Nos.")
                {
                    Caption = 'Non-Affiliated Application Nos.';
                    ApplicationArea = all;
                }

                field("Clinical SPL Considration Nos."; Rec."Clinical SPL Considration Nos.")
                {
                    ApplicationArea = all;
                }
                field("Rotation Cancel Appln Nos."; Rec."Rotation Cancel Appln Nos.")
                {
                    ApplicationArea = All;
                }
                field("Exam SPL Considration Nos."; Rec."Exam SPL Considration Nos.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics Subject Group"; Rec."Pediatrics Subject Group")
                {
                    ApplicationArea = all;
                }
                field("OBG Subject Group"; Rec."OBG Subject Group")
                {
                    ApplicationArea = All;
                }
                field("Surgery Subject Group"; Rec."Surgery Subject Group")
                {
                    ApplicationArea = All;
                }
                field("Family Medicine Subject Group"; Rec."Family Medicine Subject Group")
                {
                    ApplicationArea = All;
                }
                field("IM Subject Group"; Rec."IM Subject Group")
                {
                    ApplicationArea = All;
                }
                field("Psychiatric Subject Group"; Rec."Psychiatric Subject Group")
                {
                    ApplicationArea = All;
                }
                field("Pre Clinical Semesters"; Rec."Pre Clinical Semesters")
                {
                    ApplicationArea = All;
                }
                field("Active Statuses"; Rec."Active Statuses")
                {
                    ApplicationArea = All;
                }
                Field("Grading Status"; Rec."Grading Status")
                {
                    ApplicationArea = All;
                }
                field("Student Status for Exam"; Rec."Student Status for Exam")
                {
                    ApplicationArea = all;
                }
                Field("View/Update Doc"; Rec."View/Update Doc")
                {
                    ApplicationArea = All;
                }
                field("R-Grade Registrar Email"; Rec."R-Grade Registrar Email")
                {
                    ApplicationArea = All;
                }
                field("CLN Billing Opening Date"; Rec."CLN Billing Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Rotation Cancellation Email"; Rec."Rotation Cancellation Email")
                {
                    ApplicationArea = All;
                }
            }
            group("Logos")
            {
                field("Clinical Science Logo"; Rec."Clinical Science Logo")
                {
                    ApplicationArea = All;
                }
                field("Collage of Medicine Logo"; Rec."Collage of Medicine Logo")
                {
                    ApplicationArea = All;
                }
                field("Associate Vice President"; Rec."Associate Vice President")
                {
                    ApplicationArea = All;
                }
            }
            group(Events)
            {
                Editable = EditList;
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                }
                field("Detainee List Prepaired"; Rec."Detainee List Prepaired")
                {
                    ApplicationArea = All;
                }
                field("Internal Exam Generated"; Rec."Internal Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("Assignment  Generated"; Rec."Assignment  Generated")
                {
                    ApplicationArea = All;
                }
                field("Exam Schedule Generated"; Rec."Exam Schedule Generated")
                {
                    ApplicationArea = All;
                }
                field("External Exam Generated"; Rec."External Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("End Semester Marks Published"; Rec."End Semester Marks Published")
                {
                    ApplicationArea = All;
                }
                field("Grade Generated"; Rec."Grade Generated")
                {
                    ApplicationArea = All;
                }
                field("Regular Exam Grade Alloted"; Rec."Regular Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Regular Exam Grade Published"; Rec."Regular Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Makeup Exam Grade Alloted"; Rec."Makeup Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Makeup Exam Grade Published"; Rec."Makeup Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Rev. 1 Exam Grade Alloted"; Rec."Rev. 1 Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Rev. 1  Exam Grade Published"; Rec."Rev. 1  Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Rev. 2  Exam Grade Published"; Rec."Rev. 2  Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Grade Alloted"; Rec."Special Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Grade published"; Rec."Special Exam Grade published")
                {
                    ApplicationArea = All;
                }
                field("GPA & CGPA Generated"; Rec."GPA & CGPA Generated")
                {
                    ApplicationArea = All;
                }
                field("MakeUp Exam Schedule Generated"; Rec."MakeUp Exam Schedule Generated")
                {
                    ApplicationArea = All;
                }
                field("MakeUp External Exam Generated"; Rec."MakeUp External Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("Students Attendance Updated"; Rec."Students Attendance Updated")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks Published"; Rec."Internal Marks Published")
                {
                    ApplicationArea = All;
                }
                field("Update Detained List"; Rec."Update Detained List")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Sche. Generated"; Rec."Special Exam Sche. Generated")
                {
                    ApplicationArea = All;
                }
                field("Course Withdrawal Applicable"; Rec."Course Withdrawal Applicable")
                {
                    ApplicationArea = All;
                }
                Field("E-mail ID (SalesForce Log)"; Rec."E-mail ID (SalesForce Log)")
                {
                    ApplicationArea = All;
                }
            }
            Group("OLR Information")
            {
                group("Settlement Due Date")
                {
                    Field("Due Date 1"; Rec."Due Date1")
                    {
                        ApplicationArea = All;
                    }
                    Field("Due Date 2"; Rec."Due Date2")
                    {
                        ApplicationArea = All;
                    }
                    Field("Due Date 3"; Rec."Due Date3")
                    {
                        ApplicationArea = All;
                    }
                    Field("Due Date 4 "; Rec."Due Date4")
                    {
                        ApplicationArea = All;
                    }
                }
                Group("Insurance Agreement")
                {
                    Field("Insurance Agreement Date"; Rec."Insurance Agreement Date")
                    {
                        ApplicationArea = All;
                    }
                }
                Group("Loan Details")
                {
                    Field("FAFSA Academic Year"; Rec."FAFSA Academic Year")
                    {
                        ApplicationArea = All;
                    }
                    Field("Loan Period Date 1"; Rec."Loan Period Date 1")
                    {
                        ApplicationArea = All;
                    }

                    Field("Loan Period Date 2"; Rec."Loan Period Date 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Loan Period Date 3"; Rec."Loan Period Date 3")
                    {
                        ApplicationArea = All;
                    }
                    field("Loan Period Date 4"; Rec."Loan Period Date 4")
                    {
                        ApplicationArea = All;
                    }
                }

            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Education Setup Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;

    end;

    var
        UserSetup: Record "User Setup";
        EditList: Boolean;
}

