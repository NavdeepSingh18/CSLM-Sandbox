page 50291 "Course Detail-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                               Remarks
    // 1         CSPL-00092    23-05-2019    OnOpenPage                            User Based Filter
    // 2         CSPL-00092    23-05-2019    Course Optional Subjects - OnAction   Page Run
    // 3         CSPL-00092    23-05-2019    <Action1000000009> - OnAction         Page Run
    // 4         CSPL-00092    23-05-2019    <Action1000000010> - OnAction         Page Run

    Caption = 'Course List';
    CardPageID = "Course Detail Card-CS";
    Editable = false;
    PageType = List;
    SourceTable = "Course Master-CS";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Duration of Years"; Rec."Duration of Years")
                {
                    ApplicationArea = All;
                }
                field("Promotion Criteria"; Rec."Promotion Criteria")
                {
                    ApplicationArea = All;
                }
                field("Min. Passing Credit"; Rec."Min. Passing Credit")
                {
                    ApplicationArea = All;
                }

                field("Number of Semesters"; Rec."Number of Semesters")
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
                    Visible = false;
                }
                field("Convert Type Of Course"; Rec."Convert Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                }
                field("Enrollment Nos."; Rec."Enrollment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Course Category"; Rec."Course Category")
                {
                    ApplicationArea = all;
                }
                field("Degree Code"; Rec."Degree Code")
                {
                    ApplicationArea = all;
                }
                Field("Transcript Data Filter"; Rec."Transcript Data Filter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Course")
            {
                Caption = '&Course';

                /* action(Card)
                 {
                     Caption = 'Card';
                     Image = EditLines;
                     ShortCutKey = 'Shift+F7';
                     ApplicationArea = All;
                 }*/
                action(Section)
                {
                    Caption = 'Section';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Course Section Detail-CS";
                    RunPageLink = "Course Code" = FIELD("Code");
                    ApplicationArea = All;
                }
                action("Course Su&bjects")
                {
                    Caption = 'Course Su&bjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Course Subject H Detail-CS";
                    RunPageLink = Course = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Course Degree")
                {
                    Caption = 'Course Degree';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Course Degree";
                    // RunPageLink = "Course Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Course Optional Subjects")
                {
                    Caption = 'Course CBCS S&ubjects';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::11-05-2019: Start
                        AcademicsSetupCS.GET();
                        AcademicsSetupCS.TESTFIELD("Common Subject Type");
                        SubjectMasterCS.Reset();
                        SubjectMasterCS.SETFILTER("Subject Type", '<>%1', AcademicsSetupCS."Common Subject Type");
                        SubjectMasterCS.SETFILTER(Course, '%1|%2', Rec.Code, '');
                        IF PAGE.RUNMODAL(Page::"Subject Detail -CS", SubjectMasterCS) = ACTION::LookupOK THEN;
                        //Code added for Page Run::CSPL-00092::11-05-2019: End
                    end;
                }
                action("C&ourse Semester")
                {
                    Caption = 'C&ourse Semester';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::11-05-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            CourseSemMasterCS.Reset();
                            CourseSemMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF PAGE.RUNMODAL(Page::"Semester Course-CS", CourseSemMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is Year basis course');
                        //Code added for Page Run::CSPL-00092::11-05-2019: End
                    end;
                }
                action("Course &Year")
                {
                    Caption = 'Course &Year';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Page Run::CSPL-00092::11-05-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            CourseYearMasterCS.Reset();
                            CourseYearMasterCS.SETFILTER("Course Code", Rec.Code);
                            IF PAGE.RUNMODAL(Page::"Year Course-CS", CourseYearMasterCS) = ACTION::LookupOK THEN;
                        END ELSE
                            ERROR('This is semester basis course');
                        //Code added for Page Run::CSPL-00092::11-05-2019: Start
                    end;
                }
                action("Course Wise Faculty")
                {
                    Caption = 'Course Wise Faculty';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "Faculty-Course Wise";
                    RunPageLink = "Course Code" = FIELD("Code");
                    ApplicationArea = All;
                }
                action("Generate Course Semester")
                {
                    Image = Create;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    // trigger OnAction()
                    // Var
                    //     SemesterTempList: Page "Semester Temp List";
                    // begin
                    //     SemesterTempList.VariablePassing(Rec.Code, Rec."Global Dimension 1 Code");
                    //     SemesterTempList.RunModal();
                    // end;
                }
                action("Copy Course Semester")
                {
                    Caption = 'Copy Course Semester';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        CourseSemesterRec: Record "Course Sem. Master-CS";
                        EducationSetupRec: Record "Education Setup-CS";
                    begin
                        EducationSetupRec.Reset();
                        EducationSetupRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        EducationSetupRec.FindFirst();

                        CourseSemesterRec.Reset();
                        CourseSemesterRec.SetRange("Course Code", Rec.Code);
                        CourseSemesterRec.SetRange("Academic Year", EducationSetupRec."Academic Year");
                        If CourseSemesterRec.FindFirst() then
                            Report.Run(Report::"Copy Course Semester", True, False, CourseSemesterRec);

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for User Based Filter::CSPL-00092::11-05-2019: Start
        IF UserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF UserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for User Based Filter::CSPL-00092::11-05-2019: End
    end;

    var
        UserSetup: Record "User Setup";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        CourseYearMasterCS: Record "Course Year Master-CS";

}
