import { Body, Controller, Get, Post } from '@nestjs/common';
import { TracingService } from './tracing.service';
import { Tracing as TracingModel } from '@prisma/client';

@Controller()
export class TracingController {
  constructor(private readonly tracinService: TracingService) {}

  @Post('tracing')
  async newTracing(
    @Body('tracing')
    tracingData: {
      name: string;
      record: number;
    },
  ): Promise<TracingModel> {
    const { name, record } = tracingData;
    return this.tracinService.createTracing({
      name,
      record: {
        connect: { id: record },
      },
    });
  }
}
