page 50946 "Rotation Count"
{
    PageType = CardPart;
    UsageCategory = None;
    SourceTable = "Student Master-CS";

    layout
    {
        area(Content)
        {
            group("Student Rotations Details")
            {
                group(Core)
                {
                    field("Clinical Curriculum"; Rec."Clinical Curriculum")
                    {
                        ApplicationArea = All;
                        Caption = 'Clinical Curriculum:';
                        Style = Favorable;
                    }
                    field(FMIMDates; FMIMDates)
                    {
                        ApplicationArea = All;
                        Caption = 'FM1/IM1 Rotation Period';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                            RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                            RSL.FilterGroup(0);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }

                    Group("Core Rotations Details")
                    {
                        Group("No. of Rotations")
                        {
                            field(CoreRotationScheduled; CoreRotationScheduled)
                            {
                                ApplicationArea = All;
                                Caption = 'Rotation Scheduled:';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Scheduled);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationPublished; CoreRotationPublished)
                            {
                                ApplicationArea = All;
                                Caption = 'Rotation Published:';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Published);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationCompleted; CoreRotationCompleted)
                            {
                                ApplicationArea = All;
                                Caption = 'Rotation Completed:';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetFilter("Rotation Grade", '<>%1', 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationFailed; CoreRotationFailed)
                            {
                                ApplicationArea = All;
                                Caption = 'Rotation Failed:';
                                Style = StrongAccent;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetRange("Rotation Grade", 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                        }
                        group("Core No. of Weeks")
                        {
                            Caption = 'No. of Weeks';
                            field(FMIMWeeks; FMIMWeeks)
                            {
                                ApplicationArea = All;
                                Caption = 'FM1/IM1 Weeks:';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationWeekScheduled; CoreRotationWeekScheduled)
                            {
                                ApplicationArea = All;
                                Caption = 'Scheduled Rotation Week(s):';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Scheduled);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationWeekPublished; CoreRotationWeekPublished)
                            {
                                ApplicationArea = All;
                                Caption = 'Published Rotation Week(s):';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Published);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationWeekCompleted; CoreRotationWeekCompleted)
                            {
                                ApplicationArea = All;
                                Caption = 'Completed Rotation Week(s):';
                                Style = Unfavorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetFilter("Rotation Grade", '<>%1', 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(CoreRotationWeekFailed; CoreRotationWeekFailed)
                            {
                                ApplicationArea = All;
                                Caption = 'Failed Rotation Week(s):';
                                Style = StrongAccent;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetRange("Rotation Grade", 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                        }
                    }
                    group("Elective Rotation Details")
                    {
                        group("Elective No. of Rotations")
                        {
                            Caption = 'No. of Rotations';
                            field(ElectiveRotationScheduled; ElectiveRotationScheduled)
                            {
                                ApplicationArea = All;
                                Caption = 'Scheduled Rotation(s):';
                                Style = Favorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                    RSL.SetRange(Status, RSL.Status::Scheduled);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(ElectiveRotationPublished; ElectiveRotationPublished)
                            {
                                ApplicationArea = All;
                                Caption = 'Published Rotation(s):';
                                Style = Favorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                    RSL.SetRange(Status, RSL.Status::Published);
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(ElectiveRotationCompleted; ElectiveRotationCompleted)
                            {
                                ApplicationArea = All;
                                Caption = 'Completed Rotation(s):';
                                Style = Favorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetFilter("Rotation Grade", '<>%1', 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            field(ElectiveRotationFailed; ElectiveRotationFailed)
                            {
                                ApplicationArea = All;
                                Caption = 'Failed Rotation(s):';
                                Style = Favorable;
                                trigger OnDrillDown()
                                var
                                    RSL: Record "Roster Scheduling Line";
                                begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Student No.");
                                    RSL.FilterGroup(2);
                                    RSL.SetRange("Student No.", Rec."No.");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                    RSL.SetRange(Status, RSL.Status::Completed);
                                    RSL.SetRange("Rotation Grade", 'F');
                                    RSL.FilterGroup(0);
                                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                end;
                            }
                            group("Elective No. of Weeks")
                            {
                                Caption = 'No. of Weeks';
                                field(ElectiveRotationWeekScheduled; ElectiveRotationWeekScheduled)
                                {
                                    ApplicationArea = All;
                                    Caption = 'Scheduled Rotation Week(s):';
                                    Style = Favorable;
                                    trigger OnDrillDown()
                                    var
                                        RSL: Record "Roster Scheduling Line";
                                    begin
                                        RSL.Reset();
                                        RSL.SetCurrentKey("Student No.");
                                        RSL.FilterGroup(2);
                                        RSL.SetRange("Student No.", Rec."No.");
                                        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                        RSL.SetRange(Status, RSL.Status::Scheduled);
                                        RSL.FilterGroup(0);
                                        Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                    end;
                                }
                                field(ElectiveRotationWeekPublished; ElectiveRotationWeekPublished)
                                {
                                    ApplicationArea = All;
                                    Caption = 'Published Rotation Week(s):';
                                    Style = Favorable;
                                    trigger OnDrillDown()
                                    var
                                        RSL: Record "Roster Scheduling Line";
                                    begin
                                        RSL.Reset();
                                        RSL.SetCurrentKey("Student No.");
                                        RSL.FilterGroup(2);
                                        RSL.SetRange("Student No.", Rec."No.");
                                        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                        RSL.SetRange(Status, RSL.Status::Published);
                                        RSL.FilterGroup(0);
                                        Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                    end;
                                }
                                field(ElectiveRotationWeekCompleted; ElectiveRotationWeekCompleted)
                                {
                                    ApplicationArea = All;
                                    Caption = 'Completed Rotation Week(s):';
                                    Style = Favorable;
                                    trigger OnDrillDown()
                                    var
                                        RSL: Record "Roster Scheduling Line";
                                    begin
                                        RSL.Reset();
                                        RSL.SetCurrentKey("Student No.");
                                        RSL.FilterGroup(2);
                                        RSL.SetRange("Student No.", Rec."No.");
                                        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                        RSL.SetRange(Status, RSL.Status::Completed);
                                        RSL.SetFilter("Rotation Grade", '<>%1', 'F');
                                        RSL.FilterGroup(0);
                                        Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                    end;
                                }
                                field(ElectiveRotationWeekFailed; ElectiveRotationWeekFailed)
                                {
                                    ApplicationArea = All;
                                    Caption = 'Failed Rotation Week(s):';
                                    Style = StrongAccent;
                                    trigger OnDrillDown()
                                    var
                                        RSL: Record "Roster Scheduling Line";
                                    begin
                                        RSL.Reset();
                                        RSL.SetCurrentKey("Student No.");
                                        RSL.FilterGroup(2);
                                        RSL.SetRange("Student No.", Rec."No.");
                                        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
                                        RSL.SetRange(Status, RSL.Status::Completed);
                                        RSL.SetRange("Rotation Grade", 'F');
                                        RSL.FilterGroup(0);
                                        Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                                    end;
                                }
                            }
                        }
                        label("Seperator")
                        {
                            Caption = '=================================';
                            ApplicationArea = all;
                        }
                        field(TotalRotationWeeks; TotalRotationWeeks)
                        {
                            ApplicationArea = All;
                            Caption = 'Total Weeks:';
                            Style = Strong;
                            trigger OnDrillDown()
                            var
                                RSL: Record "Roster Scheduling Line";
                            begin
                                RSL.Reset();
                                RSL.SetCurrentKey("Student No.");
                                RSL.FilterGroup(2);
                                RSL.SetRange("Student No.", Rec."No.");
                                RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                                RSL.FilterGroup(0);
                                Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                            end;
                        }
                    }
                }
            }
        }
    }
    var
        FMIMDates: Text[100];
        FMIMWeeks: Integer;
        CoreRotationScheduled: Integer;
        CoreRotationWeekScheduled: Integer;
        CoreRotationPublished: Integer;
        CoreRotationWeekPublished: Integer;
        CoreRotationWeekFailed: Integer;
        CoreRotationCompleted: Integer;
        CoreRotationFailed: Integer;
        CoreRotationWeekCompleted: Integer;
        ElectiveRotationScheduled: Integer;
        ElectiveRotationWeekScheduled: Integer;
        ElectiveRotationPublished: Integer;
        ElectiveRotationWeekCompleted: Integer;
        ElectiveRotationCompleted: Integer;
        ElectiveRotationFailed: Integer;
        ElectiveRotationWeekPublished: Integer;
        ElectiveRotationWeekFailed: Integer;
        TotalRotationWeeks: Integer;

    trigger OnAfterGetRecord()
    var
        RSL: Record "Roster Scheduling Line";
    begin
        FMIMDates := '';
        FMIMWeeks := 0;
        CoreRotationScheduled := 0;
        CoreRotationWeekScheduled := 0;
        CoreRotationPublished := 0;
        CoreRotationWeekPublished := 0;
        ElectiveRotationScheduled := 0;
        ElectiveRotationWeekScheduled := 0;
        ElectiveRotationPublished := 0;
        ElectiveRotationWeekPublished := 0;
        TotalRotationWeeks := 0;

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
        RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
        RSL.SetFilter("Rotation Grade", '<>%1', 'F');
        //RSL.SetRange("Rotation Confirmed", true);
        if RSL.FindLast() then
            FMIMDates := Format(RSL."Start Date") + ' to ' + Format(RSL."End Date");

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
        RSL.SetFilter("Rotation Grade", '<>%1', 'F');
        RSL.CalcSums("No. of Weeks");
        FMIMWeeks := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
        RSL.SetRange(Status, RSL.Status::Scheduled);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.CalcSums("No. of Weeks");
        CoreRotationScheduled := RSL.Count;
        CoreRotationWeekScheduled := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
        RSL.SetRange(Status, RSL.Status::Published);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.CalcSums("No. of Weeks");
        CoreRotationPublished := RSL.Count;
        CoreRotationWeekPublished := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
        RSL.SetRange(Status, RSL.Status::Completed);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.SetFilter("Rotation Grade", '<>%1', 'F');
        RSL.CalcSums("No. of Weeks");
        CoreRotationCompleted := RSL.Count;
        CoreRotationWeekCompleted := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
        RSL.SetRange(Status, RSL.Status::Completed);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.SetRange("Rotation Grade", 'F');
        RSL.CalcSums("No. of Weeks");
        CoreRotationFailed := RSL.Count;
        CoreRotationWeekFailed := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
        RSL.SetRange(Status, RSL.Status::Scheduled);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.CalcSums("No. of Weeks");
        ElectiveRotationScheduled := RSL.Count;
        ElectiveRotationWeekScheduled := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
        RSL.SetRange(Status, RSL.Status::Published);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.CalcSums("No. of Weeks");
        ElectiveRotationPublished := RSL.Count;
        ElectiveRotationWeekPublished := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
        RSL.SetRange(Status, RSL.Status::Completed);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.SetFilter("Rotation Grade", '<>%1', 'F');
        RSL.CalcSums("No. of Weeks");
        ElectiveRotationCompleted := RSL.Count;
        ElectiveRotationWeekCompleted := RSL."No. of Weeks";

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
        RSL.SetRange(Status, RSL.Status::Completed);
        RSL.SetRange("Rotation Confirmed", true);
        RSL.SetRange("Rotation Grade", 'F');
        RSL.CalcSums("No. of Weeks");
        ElectiveRotationFailed := RSL.Count;
        ElectiveRotationWeekFailed := RSL."No. of Weeks";

        TotalRotationWeeks := FMIMWeeks + CoreRotationWeekScheduled + CoreRotationWeekPublished + CoreRotationWeekCompleted + ElectiveRotationWeekScheduled + ElectiveRotationWeekPublished + ElectiveRotationWeekCompleted;
    end;
}