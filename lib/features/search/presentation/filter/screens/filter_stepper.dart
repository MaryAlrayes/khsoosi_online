// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

class FilterStepper extends StatelessWidget {
  final List<Map<String, dynamic>> steps;
  final VoidCallback search;
  const FilterStepper({
    Key? key,
    required this.steps,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterStepperCubit, FilterStepperState>(
      builder: (context, state) {
        return Stepper(
          key: Key("mysuperkey-" + steps.length.toString()),
          physics: NeverScrollableScrollPhysics(),
          stepIconBuilder: (stepIndex, stepState) {
            if (stepIndex <= state.currentStep) {
              return _buildStepNumber(
                  stepIndex: stepIndex, color: ColorManager.orange);
            } else {
              return _buildStepNumber(
                  stepIndex: stepIndex, color: ColorManager.gray4);
            }
          },
          onStepTapped: (index) {
            BlocProvider.of<FilterStepperCubit>(context).setStep(index);
          },
          controlsBuilder: (context, details) {
            return _buildControlsBtn(context, state.currentStep);
          },
          currentStep: state.currentStep,
          steps: steps
              .map(
                (e) => Step(
                  title: Text(
                    e['title'],
                    style: TextStyle(fontSize: 14),
                  ),
                  content:
                      Padding(padding: EdgeInsets.all(4), child: e['content']),
                  state: StepState.indexed,
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildControlsBtn(BuildContext context, int currentStep) {
    return steps[currentStep].containsKey('enableControlBtn') &&
            !steps[currentStep]['enableControlBtn']
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: currentStep == steps.length - 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NextPreviousBtn(
                          nextOrPrevious: NextOrPrevious.previous,
                          onPressed: () {
                            BlocProvider.of<FilterStepperCubit>(context)
                                .previousStep();
                          }),
                      SizedBox(
                        width: 8,
                      ),
                      CustomElevatedButton(
                        label: 'بحث',
                        onPressed: search,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentStep > 0
                          ? NextPreviousBtn(
                              nextOrPrevious: NextOrPrevious.previous,
                              onPressed: () {
                                BlocProvider.of<FilterStepperCubit>(context)
                                    .previousStep();
                              })
                          : Container(),
                      SizedBox(
                        width: 8,
                      ),
                      NextPreviousBtn(
                          nextOrPrevious: NextOrPrevious.next,
                          onPressed: () {
                            BlocProvider.of<FilterStepperCubit>(context)
                                .nextStep();
                          })
                    ],
                  ),
          );
  }

  CircleAvatar _buildStepNumber({
    required int stepIndex,
    required Color color,
  }) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        '${stepIndex + 1}',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
      ),
    );
  }
}
