import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { TracingService } from './tracing.service';
import { Tracing as TracingModel } from '@prisma/client';
import { UpdateTracingDto } from './dto/update-tracing.dto';

@Controller()
export class TracingController {
  constructor(private readonly tracinService: TracingService) {}

  // OBTENER TODOS LOS SEGUIMIENTOS
  @Get('tracings')
  async getTracings(): Promise<TracingModel[]> {
    return this.tracinService.tracings({});
  }

  // OBTENER EL SEGUIMIENTO COMPLETO POR ID
  @Get('tracing/:id')
  async getTracingById(@Param('id') id: string): Promise<TracingModel> {
    return this.tracinService.tracing({ id: Number(id) });
  }

  // CREAR SEGUIMIENTO
  @Post('tracing')
  async newTracing(
    @Body()
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

  // EDITAR SEGUMIENTO
  @Patch('tracing/:id')
  async editTracing(
    @Param('id') id: number,
    @Body() updateTracingDto: UpdateTracingDto,
  ): Promise<TracingModel> {
    return this.tracinService.updateTracing(+id, updateTracingDto);
  }

  // ELIMINAR SEGUIMIENTO
  @Delete('tracing/:id')
  async removeTracing(@Param('id') id: string): Promise<TracingModel> {
    return this.tracinService.deleteTracing({ id: Number(id) });
  }
}
