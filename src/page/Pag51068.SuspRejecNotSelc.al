page 51068 "Suspended/Rejected/Not"
{

    ApplicationArea = All;
    Caption = 'Suspended/ Rejected Medical Scholar Program List';
    PageType = List;
    SourceTable = "Medical Scholar Program";
    UsageCategory = Lists;
    SourceTableView = Sorting("Application Date") Order(descending) where("Application Status" = filter(Suspended | Rejected));
    CardPageId = "Interview Confirmed Card";//CSPL-00307 
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
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
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Skype Id"; Rec."Skype Id")
                {
                    ApplicationArea = All;
                }
                field("First Time Applicant"; Rec."First Time Applicant")
                {
                    ApplicationArea = All;
                }
                field("Previously Medical Scholar"; Rec."Previously Medical Scholar")
                {
                    ApplicationArea = All;
                }
                field("Previous Role 1"; Rec."Previous Role 1")
                {
                    ApplicationArea = All;
                }
                field("Previous Role 2"; Rec."Previous Role 2")
                {
                    ApplicationArea = All;
                }
                field("Applying New Role"; Rec."Applying New Role")
                {
                    ApplicationArea = All;
                }
                field("Maintain Same Role"; Rec."Maintain Same Role")
                {
                    ApplicationArea = All;
                }
                field("Role Applying"; Rec."Role Applying")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Cumulative GPA above 3"; Rec."Cumulative GPA above 3")
                {
                    ApplicationArea = All;
                }
                field("Academic Prob for upcoming Sem"; Rec."Academic Prob for upcoming Sem")
                {
                    ApplicationArea = All;
                }
                field("Participated in Reboot program"; Rec."Participated in Reboot program")
                {
                    ApplicationArea = All;
                }
                field("1st Choice for Position"; Rec."1st Choice for Position")
                {
                    ApplicationArea = All;
                }
                field("1st Choice Lead Role"; Rec."1st Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("2nd Choice for Position"; Rec."2nd Choice for Position")
                {
                    ApplicationArea = All;
                }
                field("2nd Choice Lead Role"; Rec."2nd Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("3rd Choice for Position"; Rec."3rd Choice for Position")
                {
                    ApplicationArea = All;
                }
                field("3rd Choice Lead Role"; Rec."3rd Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("4th Choice for Position"; Rec."4th Choice for Position")
                {
                    ApplicationArea = All;
                }
                field("4th Choice Lead Role"; Rec."4th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("5th Choice Lead Role"; Rec."5th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("6th Choice Lead Role"; Rec."6th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("7th Choice Lead Role"; Rec."7th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("Reference 1"; Rec."Reference 1")
                {
                    ApplicationArea = All;
                }
                field("Reference 2"; Rec."Reference 2")
                {
                    ApplicationArea = All;
                }
                field(Questions_comments; Rec.Questions_comments)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_New_1_Experience; Rec.ShortQ_New_1_Experience)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_New_2_Motivation; Rec.ShortQ_New_2_Motivation)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_New_3_Advice; Rec.ShortQ_New_3_Advice)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_New_4_Integrity_Ethic; Rec.ShortQ_New_4_Integrity_Ethic)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_New_5_professionalism; Rec.ShortQ_New_5_professionalism)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_Repeat_1_contribution; Rec.ShortQ_Repeat_1_contribution)
                {
                    ApplicationArea = All;
                }
                field(ShortQ_Repeat_2_rationale; Rec.ShortQ_Repeat_2_rationale)
                {
                    ApplicationArea = All;
                }
                field("Interested in being lead"; Rec."Interested in being lead")
                {
                    ApplicationArea = All;
                }
                field("List of SO and affiliations"; Rec."List of SO and affiliations")
                {
                    ApplicationArea = All;
                }
                field("Member or officer of stud org."; Rec."Member or officer of stud org.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
