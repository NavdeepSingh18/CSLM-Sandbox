report 50071 ExternalExamStats
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/ExternalInternalExamStats.rdl';
    Caption = 'External/Internal Exam Stats';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number = filter(1));
            column(ExamType; ExamType)
            { }
            column(InstituteCodeFilter; InstituteCodeFilter)
            { }
            column(AcademicYearFilter; AcademicYearFilter)
            { }
            column(TermFilter; TermFilter)
            { }
            column(SemesterFilter; SemesterFilter)
            { }
            column(SubjectFilter; SubjectFilter)
            { }
            column(SubjectDescription; SubjectDescription)
            { }
            column(MaximumWeightageValue; MaximumWeightageValue)
            { }
            column(CountValue; CountValue)
            { }
            column(MinValue; MinValue)
            { }
            column(MaxValue; MaxValue)
            { }
            column(RangeValue; RangeValue)
            { }
            column(TotalPercentageObtained; TotalPercentageObtained)
            { }
            column(AverageValue; AverageValue)
            { }
            column(MedianValue; MedianValue)
            { }
            column(StandardDeviation; StandardDeviation)
            { }
            column(VarianceValue; VarianceValue)
            { }
            column(Count1; Count1)
            { }
            column(Count2; Count2)
            { }
            column(Count3; Count3)
            { }
            column(Count4; Count4)
            { }
            column(Count5; Count5)
            { }
            column(Count6; Count6)
            { }
            column(Count7; Count7)
            { }
            column(Count8; Count8)
            { }
            column(Count9; Count9)
            { }
            column(Count10; Count10)
            { }
            column(Count11; Count11)
            { }
            column(Count12; Count12)
            { }
            trigger OnPreDataItem()
            begin
                If ExamType = ExamType::" " then
                    Error('Please select Exam Type as either External or Internal');
                IF InstituteCodeFilter = '' then
                    Error('Please select Institute Code Filter');
                IF AcademicYearFilter = '' then
                    Error('Please select Academic Year Filter');
                If TermFilter = TermFilter::" " then
                    Error('Please select Term Filter');
                if SemesterFilter = '' then
                    Error('Please select Semester Filter');
                If SubjectFilter = '' then
                    Error('Please select Subject Filter');
            end;

            trigger OnAfterGetRecord()
            var
                ExternalExamLine: Record "External Exam Line-CS";
                InternalExamLine: Record "Internal Exam Line-CS";
                Int: Integer;
            Begin
                MaximumWeightageValue := 0;
                CountValue := 0;
                MinValue := 0;
                MaxValue := 0;
                RangeValue := 0;
                AverageValue := 0;
                MedianValue := 0;
                Clear(MedianValueN);
                StandardDeviation := 0;
                VarianceValue := 0;
                Count1 := 0;
                Count2 := 0;
                Count3 := 0;
                Count4 := 0;
                Count5 := 0;
                Count6 := 0;
                MedianCount := 0;
                Int := 0;
                Count7 := 0;
                Count8 := 0;
                Count9 := 0;
                Count10 := 0;
                Count11 := 0;
                Count12 := 0;

                If ExamType = ExamType::"External Exam" then begin
                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    CountValue := ExternalExamLine.Count();

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetCurrentKey("Obtained Weightage");
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If ExternalExamLine.FindFirst() then begin
                        MinValue := ExternalExamLine."Obtained Weightage";
                        MaximumWeightageValue := ExternalExamLine."Maximum Weightage";
                    end;
                    If ExternalExamLine.FindLast() then
                        MaxValue := ExternalExamLine."Obtained Weightage";

                    RangeValue := MaxValue - MinValue;

                    TotalPercentageObtained := 0;
                    MeanValue := 0;
                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.CalcSums("Obtained Weightage");
                    AverageValue := ExternalExamLine."Obtained Weightage";
                    MeanValue := Round(AverageValue / CountValue);

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If ExternalExamLine.Findset() then begin
                        Repeat
                            TotalPercentageObtained += Round(Power(ExternalExamLine."Obtained Weightage" - MeanValue, 2));
                        until ExternalExamLine.Next() = 0;
                    end;

                    TotalPercentageObtained := Round(TotalPercentageObtained / CountValue);
                    TotalPercentageObtained := Power(TotalPercentageObtained, 1 / 2);
                    VarianceValue := Power(TotalPercentageObtained, 2);

                    AverageValue := Round(AverageValue / CountValue);

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If ExternalExamLine.FindSet() then begin
                        Repeat
                            Int += 1;
                            MedianValueN[Int] := ExternalExamLine."Obtained Weightage";
                        until ExternalExamLine.Next() = 0;
                    end;



                    If (CountValue Mod 2) = 0 then begin
                        MedianCount := CountValue / 2;
                        IF MedianCount > 1 then
                            MedianValue := (MedianValueN[MedianCount] + MedianValueN[MedianCount - 1]) / 2
                        Else
                            MedianValue := (MedianValueN[MedianCount]) / 2;
                    end Else begin
                        MedianCount := (CountValue + 1) / 2;
                        MedianValue := MedianValueN[MedianCount];
                    end;




                    Count1 := 0;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 0, 9);
                    Count2 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 10, 19);
                    Count3 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 20, 29);
                    Count4 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 30, 39);
                    Count5 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 40, 49);
                    Count6 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 50, 59);
                    Count7 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 60, 69);
                    Count8 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 70, 79);
                    Count9 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 80, 89);
                    Count10 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetRange("External Mark", 90, 100);
                    Count11 := ExternalExamLine.Count;

                    ExternalExamLine.Reset();
                    ExternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    ExternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    ExternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        ExternalExamLine.SetRange(Term, ExternalExamLine.Term::SUMMER);
                    ExternalExamLine.SetRange("Subject Code", SubjectFilter);
                    ExternalExamLine.SetFilter("External Mark", '>%1', 100);
                    Count12 := ExternalExamLine.Count;
                end;

                If ExamType = ExamType::"Internal Exam" then begin

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    CountValue := InternalExamLine.Count();

                    InternalExamLine.Reset();
                    InternalExamLine.SetCurrentKey("Obtained Weightage");
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If InternalExamLine.FindFirst() then begin
                        MinValue := InternalExamLine."Obtained Weightage";
                        MaximumWeightageValue := InternalExamLine."Maximum Weightage";
                    end;
                    If InternalExamLine.FindLast() then
                        MaxValue := InternalExamLine."Obtained Weightage";

                    RangeValue := MaxValue - MinValue;

                    TotalPercentageObtained := 0;
                    MeanValue := 0;
                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.CalcSums("Obtained Weightage");
                    AverageValue := InternalExamLine."Obtained Weightage";
                    MeanValue := Round(AverageValue / CountValue);

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If InternalExamLine.Findset() then begin
                        Repeat
                            TotalPercentageObtained += Round(Power(InternalExamLine."Obtained Weightage" - MeanValue, 2));
                        until InternalExamLine.Next() = 0;
                    end;

                    TotalPercentageObtained := Round(TotalPercentageObtained / CountValue);
                    TotalPercentageObtained := Power(TotalPercentageObtained, 1 / 2);
                    VarianceValue := Power(TotalPercentageObtained, 2);


                    AverageValue := Round(AverageValue / CountValue);

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    If InternalExamLine.FindSet() then begin
                        Repeat
                            Int += 1;
                            MedianValueN[Int] := InternalExamLine."Obtained Weightage";
                        until InternalExamLine.Next() = 0;
                    end;

                    If (CountValue Mod 2) = 0 then begin
                        MedianCount := CountValue / 2;
                        IF MedianCount > 1 then
                            MedianValue := (MedianValueN[MedianCount] + MedianValueN[MedianCount - 1]) / 2
                        Else
                            MedianValue := (MedianValueN[MedianCount]) / 2;
                    end Else begin
                        MedianCount := (CountValue + 1) / 2;
                        MedianValue := MedianValueN[MedianCount];
                    end;


                    MedianValue := 0;
                    StandardDeviation := 0;
                    VarianceValue := 0;

                    Count1 := 0;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 0, 9);
                    Count2 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 10, 19);
                    Count3 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 20, 29);
                    Count4 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 30, 39);
                    Count5 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 40, 49);
                    Count6 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 50, 59);
                    Count7 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 60, 69);
                    Count8 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 70, 79);
                    Count9 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 80, 89);
                    Count10 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetRange("Obtained Internal Marks", 90, 100);
                    Count11 := InternalExamLine.Count;

                    InternalExamLine.Reset();
                    InternalExamLine.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                    InternalExamLine.SetRange("Academic year", AcademicYearFilter);
                    InternalExamLine.SetRange(Semester, SemesterFilter);
                    If TermFilter = TermFilter::FALL then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::FALL);
                    IF TermFilter = TermFilter::SPRING then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SPRING);
                    If TermFilter = TermFilter::SUMMER then
                        InternalExamLine.SetRange(Term, InternalExamLine.Term::SUMMER);
                    InternalExamLine.SetRange("Subject Code", SubjectFilter);
                    InternalExamLine.SetFilter("Obtained Internal Marks", '>%1', 100);
                    Count12 := InternalExamLine.Count;
                end;

            End;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Request Filter")
                {
                    Field(ExamType; ExamType)
                    {
                        Caption = 'Exam Type';
                    }
                    field(InstituteCodeFilter; InstituteCodeFilter)
                    {
                        Caption = 'Institute Code Filter';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field(AcademicYearFilter; AcademicYearFilter)
                    {
                        Caption = 'Academic Year Filter';
                        TableRelation = "Academic Year Master-CS";
                    }
                    field(TermFilter; TermFilter)
                    {
                        Caption = 'Term Filter';
                    }
                    field(SemesterFilter; SemesterFilter)
                    {
                        Caption = 'Semester Filter';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Semester_lRec: Record "Semester Master-CS";
                        Begin
                            If InstituteCodeFilter = '' then
                                Error('Please select Institute Code Filter');
                            Semester_lRec.Reset();
                            Semester_lRec.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                            If Page.RunModal(0, Semester_lRec) = Action::LookupOK then
                                SemesterFilter := Semester_lRec.Code;
                        End;
                    }
                    field(SubjectFilter; SubjectFilter)
                    {
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ExternalExamHdr: Record "External Exam Header-CS";
                            InternalExamHdr: Record "Internal Exam Header-CS";
                        Begin
                            If InstituteCodeFilter = '' then
                                Error('Please select Institute Code Filter');
                            If AcademicYearFilter = '' then
                                Error('Please select Academic Year Filter');
                            If TermFilter = TermFilter::" " then
                                Error('Please select Term Filter');
                            IF SemesterFilter = '' then
                                Error('Please select Semester Filter');
                            If ExamType = ExamType::" " then
                                Error('Please select Exam Type as either External or Internal');

                            If ExamType = ExamType::"External Exam" then begin
                                ExternalExamHdr.Reset();
                                ExternalExamHdr.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                                ExternalExamHdr.SetRange("Academic Year", AcademicYearFilter);
                                If TermFilter = TermFilter::FALL then
                                    ExternalExamHdr.SetRange(Term, ExternalExamHdr.Term::FALL);
                                If TermFilter = TermFilter::SPRING then
                                    ExternalExamHdr.SetRange(Term, ExternalExamHdr.Term::SPRING);
                                If TermFilter = TermFilter::SUMMER then
                                    ExternalExamHdr.SetRange(Term, ExternalExamHdr.Term::SUMMER);
                                ExternalExamHdr.SetRange(Semester, SemesterFilter);
                                IF page.RunModal(50985, ExternalExamHdr) = Action::LookupOK then begin
                                    SubjectFilter := ExternalExamHdr."Subject Code";
                                    SubjectDescription := ExternalExamHdr."Subject Description";
                                end;
                            end;
                            If ExamType = ExamType::"Internal Exam" then begin
                                InternalExamHdr.Reset();
                                InternalExamHdr.SetRange("Global Dimension 1 Code", InstituteCodeFilter);
                                InternalExamHdr.SetRange("Academic Year", AcademicYearFilter);
                                InternalExamHdr.SetRange(Semester, SemesterFilter);
                                If TermFilter = TermFilter::FALL then
                                    InternalExamHdr.SetRange(Term, InternalExamHdr.Term::FALL);
                                If TermFilter = TermFilter::SPRING then
                                    InternalExamHdr.SetRange(Term, InternalExamHdr.Term::SPRING);
                                If TermFilter = TermFilter::SUMMER then
                                    InternalExamHdr.SetRange(Term, InternalExamHdr.Term::SUMMER);
                                If Page.RunModal(50984, InternalExamHdr) = Action::LookupOK then begin
                                    SubjectFilter := InternalExamHdr."Subject Code";
                                    SubjectDescription := InternalExamHdr."Subject Description";
                                end;
                            end;
                        End;
                    }
                }
            }
        }

    }



    var
        SubjectFilter: Code[20];
        AcademicYearFilter: Code[20];
        TermFilter: Option " ",FALL,SPRING,SUMMER;
        SemesterFilter: Code[20];
        InstituteCodeFilter: Code[20];
        SubjectDescription: Text[100];
        CountValue: Integer;
        MinValue: Decimal;
        MaxValue: Decimal;
        RangeValue: Decimal;
        AverageValue: Decimal;
        MedianValue: Decimal;
        MedianValueN: Array[1000] of Decimal;
        StandardDeviation: Decimal;
        VarianceValue: Decimal;
        Count1: Integer;
        Count2: Integer;
        Count3: Integer;
        Count4: Integer;
        Count5: Integer;
        Count6: Integer;
        Count7: Integer;
        Count8: Integer;
        Count9: Integer;
        Count10: Integer;
        Count11: Integer;
        Count12: Integer;
        ExamType: Option " ","External Exam","Internal Exam";
        MaximumWeightageValue: Decimal;
        MedianCount: Integer;
        TotalPercentageObtained: Decimal;
        MeanValue: Decimal;



}