page 51063 "Interview Confirmed Card"
{

    UsageCategory = None;
    Caption = 'Medical Scholar Card';
    PageType = Card;
    SourceTable = "Medical Scholar Program";
    layout
    {
        area(content)
        {
            Group(General)
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
                    Editable = false;
                }
                field("Rejection Code"; Rec."Rejection Code")
                {
                    // Visible = VisibleRejectFields;
                    ToolTip = 'Specifies the value of the Rejection Code field.';
                    ApplicationArea = All;
                }
                field("Rejection Reason Description"; Rec."Rejection Reason Description")
                {
                    // Visible = VisibleRejectFields;
                    ToolTip = 'Specifies the value of the Rejection Reason Description field.';
                    ApplicationArea = All;
                }
                field("Role Offered"; Rec."Role Offered New")
                {
                    // Visible = (ApprovedPage OR SelectedPage);
                    ToolTip = 'Specifies the value of the Role Offered field.';
                    ApplicationArea = All;
                }
            }
            Group("Contact Details")
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                }
                Field("AUA E-mail"; Rec."AUA E-mail")
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
                    Visible = false;
                    ToolTip = 'Specifies the value of the Skype Id field.';
                    ApplicationArea = All;

                }


            }
            Group("Applicant Status")
            {
                field("Returning Scholar"; Rec."Returning Scholar")
                {
                    ToolTip = 'Specifies the value of the Are you a Returning Scholar? field.';
                    ApplicationArea = All;
                }
                field("First Time Applicant"; Rec."First Time Applicant")
                {
                    ApplicationArea = All;
                }
                field("Previously Medical Scholar"; Rec."Previously Medical Scholar")
                {
                    ApplicationArea = All;
                    Caption = 'I have been previously selected as a Medical Scholar';
                }
                field("Previous Role 1"; Rec."Previous Role 1")
                {
                    Caption = 'Previous Role';
                    ApplicationArea = All;
                }
                field("Previous Role 2"; Rec."Previous Role 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Role Applying"; Rec."Role Applying")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applying New Role"; Rec."Applying New Role")
                {
                    Caption = 'Applying for a New Position';
                    ApplicationArea = All;
                }
                field("Maintain Same Role"; Rec."Maintain Same Role")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    Caption = 'Role and Course Name';
                    ApplicationArea = All;
                }



            }
            Group("Academic Performance & Accounts Hold")
            {
                field("Cumulative GPA above 3"; Rec."Cumulative GPA above 3")
                {
                    ApplicationArea = all;
                }
                Field("Academic Prob for upcoming Sem"; Rec."Academic Prob for upcoming Sem")
                {
                    ApplicationArea = All;
                }
                field("Repeated any Semester"; Rec."Repeated any Semester")
                {
                    ToolTip = 'Specifies the value of the Have you repeated any Semester in AUA? (Yes/No) field.';
                    ApplicationArea = All;
                }

            }
            Group("EED Reboot Program")
            {
                Visible = false;
                Field("Participated in Reboot program"; Rec."Participated in Reboot program")
                {
                    ApplicationArea = All;
                }
                field("Participated in Reboot program PrevSem"; Rec."Participated in Reboot program PrevSem")
                {
                    ToolTip = 'Specifies the value of the Participated in Reboot program in previous Semester field.';
                    ApplicationArea = All;
                }
            }
            Group("Position Choices")
            {
                field("1st Choice for Position"; Rec."1st Choice for Position")
                {
                    ApplicationArea = All;

                }
                Field("2nd Choice for Position"; Rec."2nd Choice for Position")
                {
                    ApplicationArea = All;
                }
                Field("3rd Choice for Position"; Rec."3rd Choice for Position")
                {
                    ApplicationArea = All;
                }
                Field("4th Choice for Position"; Rec."4th Choice for Position")
                {
                    ApplicationArea = All;
                }

            }
            part(Med1; "Medical Scholars SubForm")
            {
                Caption = 'Med 1 Subject';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Application No"), "Semster No" = const('MED1');
            }
            part(Med2; "Medical Scholars SubForm")
            {
                Caption = 'Med 2 Subject';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Application No"), "Semster No" = const('MED2');
            }
            part(Med3; "Medical Scholars SubForm")
            {
                Caption = 'Med 3 Subject';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Application No"), "Semster No" = const('MED3');
            }
            part(Med4; "Medical Scholars SubForm")
            {
                Caption = 'Med 4 Subject';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Application No"), "Semster No" = const('MED4');
            }
            group("Lead Positions")
            {
                // Visible = (Not "First Time Applicant");
                field("Interested in being lead"; Rec."Interested in being lead")
                {
                    ApplicationArea = All;
                }
                Field("1st Choice Lead Role"; Rec."1st Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                Field("2nd Choice Lead Role"; Rec."2nd Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                Field("3rd Choice Lead Role"; Rec."3rd Choice Lead Role")
                {
                    ApplicationArea = all;
                }
                Field("4th Choice Lead Role"; Rec."4th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                Field("5th Choice Lead Role"; Rec."5th Choice Lead Role")
                {
                    ApplicationArea = All;
                }
                field("6th Choice Lead Role"; Rec."6th Choice Lead Role")
                {
                    ApplicationArea = all;
                }
                field("7th Choice Lead Role"; Rec."7th Choice Lead Role")
                {
                    ApplicationArea = all;
                }
            }
            group("Short Answer Questions (Returning Students)")
            {
                field(ShortQ_Repeat_1_contribution; Rec.ShortQ_Repeat_1_contribution)
                {
                    Caption = '1. Describe how your involvement in the Medical Scholars Program has contributed to your growth and development as an aspiring physician.*';
                    ApplicationArea = all;
                    MultiLine = true;

                }
                field(ShortQ_Repeat_2_rationale; Rec.ShortQ_Repeat_2_rationale)
                {
                    Caption = '2a. If you are re-applying for the same position you have held previously, explain your rationale for returning to the same position. OR 2b. If you are applying for a different position than you have held previously, explain your rationale for applying to the new position. *';
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            Group("Short Answer Questions (New Applicants)")
            {
                Field(ShortQ_New_1_Experience; Rec.ShortQ_New_1_Experience)
                {
                    Caption = 'Please list any relevant experiences you have with teaching, tutoring, facilitating small groups, delivering presentations [TA/Tutor]. *';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                Field(ShortQ_New_2_Motivation; Rec.ShortQ_New_2_Motivation)
                {
                    Caption = 'What motivates you to become a Medical Scholar? ';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                Field(ShortQ_New_3_Advice; Rec.ShortQ_New_3_Advice)
                {
                    Caption = 'What advice would you give a first semester student about how to be successful in medical school? *';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                Field(ShortQ_New_4_Integrity_Ethic; Rec.ShortQ_New_4_Integrity_Ethic)
                {
                    Caption = 'Describe your integrity and work ethic. *';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                Field(ShortQ_New_5_professionalism; Rec.ShortQ_New_5_professionalism)
                {
                    Caption = 'How would professionalism play into your role as a medical scholar? *';
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            group("Campus Involvement & Student Organizations")
            {

                field("Member or officer of stud org."; Rec."Member or officer of stud org.")
                {
                    Caption = 'I will be a member of or an officer for a Student Organization during the new, upcoming semester: *';
                    ApplicationArea = All;
                }
            }
            group("Campus Involvement & Student Organizations (Continued)")
            {
                field("List of SO and affiliations"; Rec."List of SO and affiliations")
                {
                    Caption = 'List the Student Organizations and your affiliations in the text box below: *';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group("References")
            {
                field("Reference 1"; Rec."Reference 1")
                {
                    Caption = 'AUA Faculty Member #1';
                    ApplicationArea = All;
                }
                field("Reference 2"; Rec."Reference 2")
                {
                    Caption = 'AUA Faculty Member #2';
                    ApplicationArea = All;
                }
            }
            group("Questions/Comments")
            {
                field(Questions_comments; Rec.Questions_comments)
                {
                    Caption = 'Please type any additional questions/comments in the space provided. [Your questions/comments cannot exceed 1,000 characters (approximately 200 words).] ';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }

    }


    actions
    {

        area(Processing)
        {
            action("Select")
            {
                // Visible = InterviewPage;
                Visible = ApprovedPage;
                ApplicationArea = All;
                Image = Approval;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Select Application No. %1 ?', true, Rec."Application No") then
                        exit;
                    Rec.TestField("Student No.");
                    Rec.TestField("Role Offered New");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::Selected);
                    Rec.Modify();
                    Message('Student No. %1 has been Selected', Rec."Student No.");
                    IF Rec."Interested in being lead" then
                        //LeadSelectedMail()////GMCSCOM
                        //else
                        // RegularSelectedMail();////GMCSCOM
                        CurrPage.Close();

                end;
            }
            action("Not Selected")
            {
                // Visible = InterviewPage;
                Caption = 'Deselect';
                Visible = ApprovedPage;
                ApplicationArea = All;
                Image = Reject;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Deselect Application No. %1 ?', true, Rec."Application No") then
                        exit;

                    Rec.TestField("Rejection Reason Description");
                    Rec.TestField("Student No.");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::NotSelected);
                    Rec.Modify();
                    Message('Student No. %1 has been Deselected', Rec."Student No.");
                    CurrPage.Close();
                end;
            }
            action("Interview Confirmed")
            {
                // Visible = ApprovedPage;
                Visible = false;
                ApplicationArea = All;
                Image = InterviewConfirmed;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Confirme Interview for Application No. %1 ?', true, Rec."Application No") then
                        exit;

                    Rec.TestField("Student No.");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::"Interview Confirmed");
                    Rec.Modify();
                    Message('Medical Scholar Application No. %1 Interview is Confirmed', Rec."Application No");
                    //InterviewConfirmedMail();//GMCSCOM
                    CurrPage.Update();
                end;
            }
            action("Approve")
            {
                Visible = PendingPage;
                ApplicationArea = All;
                Image = Approve;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Approve Application No. %1 ?', true, Rec."Application No") then
                        exit;

                    Rec.TestField("Student No.");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::Approved);
                    Rec.Modify();
                    Message('Medical Scholar Application No. %1 is Approved', Rec."Application No");
                    IF Rec."Interested in being lead" THEN
                        // LeadApprovedMail()//GMCSCOM
                        // else
                        //RegularApproved();//GMCSCOM
                        CurrPage.Close();
                end;
            }
            action("Suspend")
            {
                Visible = PendingPage;
                ApplicationArea = All;
                Image = Reject;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Suspend Application No. %1 ?', true, Rec."Application No") then
                        exit;

                    Rec.TestField("Student No.");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::Suspended);
                    Rec.Modify();
                    Message('Medical Scholar Application No. %1 is Suspended', Rec."Application No");
                    //SuspendAppMail();//GMCSCOM
                    CurrPage.Close();
                end;
            }

            action("Reject")
            {
                Visible = PendingPage;
                ApplicationArea = All;
                Image = Reject;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    IF not Confirm('Do you want to Reject Application No. %1 ?', true, Rec."Application No") then
                        exit;

                    Rec.TestField("Student No.");
                    Rec.TestField("Rejection Reason Description");
                    Rec.Validate(Rec."Application Status", Rec."Application Status"::Rejected);
                    Rec.Modify();
                    Message('Medical Scholar Application No. %1 is Rejected', Rec."Application No");
                    IF Rec."Interested in being lead" THEN
                        // LeadRejectedMail()//GMCSCOM
                        //else
                        //RegularRejectAppMail();//GMCSCOM
                        CurrPage.Close();
                end;
            }
            action("Student Subject Grade Book List")
            {
                Visible = PendingPage;
                ApplicationArea = All;
                Image = List;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = Page StudentSubjectGradeBookList;
                RunPageLink = "Student No." = field("Student No.");
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                PromotedCategory = Process;
                Promoted = true;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    RecStud: Record "Student Master-CS";
                begin
                    RecStud.Reset();
                    RecStud.SetRange("No.", Rec."Student No.");
                    Page.RunModal(50295, RecStud);
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IF Rec."Application Status" IN [Rec."Application Status"::Pending, Rec."Application Status"::" "] then
            PendingPage := true
        else
            PendingPage := false;

        if Rec."Application Status" = Rec."Application Status"::Approved then
            ApprovedPage := true
        else
            ApprovedPage := false;

        if Rec."Application Status" = Rec."Application Status"::"Interview Confirmed" then
            InterviewPage := true
        else
            InterviewPage := false;

        if Rec."Application Status" IN [Rec."Application Status"::Suspended, Rec."Application Status"::Rejected] then
            SuspendedPage := true
        else
            SuspendedPage := false;

        if Rec."Application Status" IN [Rec."Application Status"::Suspended, Rec."Application Status"::Pending, Rec."Application Status"::Rejected] then
            VisibleRejectFields := true
        else
            VisibleRejectFields := false;

        IF Rec."Application Status" <> Rec."Application Status"::Pending then
            CurrPage.Editable(false);

    end;

    trigger OnOpenPage()
    begin
        IF Rec."Application Status" IN [Rec."Application Status"::Selected, Rec."Application Status"::NotSelected] then
            CurrPage.Caption := 'Selected/ Not Selected Applicant Medical Scholar Card';

        IF Rec."Application Status" IN [Rec."Application Status"::Suspended, Rec."Application Status"::Rejected] then
            CurrPage.Caption := 'Suspended/ Rejected Medical Scholar Card';

        IF Rec."Application Status" = Rec."Application Status"::"Interview Confirmed" then
            CurrPage.Caption := 'Interview Confirmed Medical Scholar�s Card';

        IF Rec."Application Status" = Rec."Application Status"::Pending then
            CurrPage.Caption := 'Pending Medical Scholar Card';

        IF Rec."Application Status" = Rec."Application Status"::Approved then
            CurrPage.Caption := 'Approved Medical Scholar Card';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    //myInt: Integer;
    begin
        IF Rec."Application Status" = Rec."Application Status"::" " then begin
            Rec.Validate("Application Status", Rec."Application Status"::Pending);
            PendingPage := true;
        end;
        // IF Not (Rec."Application Status" IN [Rec'Pending' then
        //     Error('Use Pending Medical Scholar Page to Insert New Record');
    end;



    // trigger OnDeleteRecord(): Boolean
    // var
    // //myInt: Integer;
    // begin
    //     IF Not (Rec."Application Status" IN [Rec."Application Status"::" ", Rec."Application Status"::Pending]) then
    //         Error('You Can not Delete the Document with status %1', Rec."Application Status");

    // end;

    var
        PendingPage: Boolean;
        ApprovedPage: Boolean;

        SelectedPage: Boolean;
        SuspendedPage: Boolean;
        InterviewPage: Boolean;
        VisibleRejectFields: Boolean;
}
