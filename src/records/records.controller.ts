import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../auth.guard';
import { RecordsService } from './records.service';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';
import { QueryDto } from './dto/query.dto';

import { Prisma, Record as RecordModel, Tracing } from '@prisma/client';
import { Priority } from '@prisma/client';

@Controller('records')
@UseGuards(AuthGuard)
export class RecordsController {
  constructor(private readonly recordsService: RecordsService) {}

  // CREAR EXPEDIENTE
  @Post()
  async create(@Body() createRecordDto: CreateRecordDto): Promise<RecordModel> {
    return this.recordsService.create(createRecordDto);
  }

  // OBTENER TODOS LOS EXPEDIENTES
  @Get('')
  findAll(): Promise<RecordModel[]> {
    return this.recordsService.findAll({
      include: {
        parts: {
          select: {
            user: true,
          },
        },
      },
    });
  }

  // OBTENER TODOS LOS EXPEDIENTES FILTRADOS
  @Get('filter')
  findSearch(@Query() query: QueryDto): Promise<RecordModel[]> {
    const { search, priority, tracing, take, ...orderByOptions } = query;

    return this.recordsService.findAll({
      where: {
        order: {
          contains: !!search && search.match(/\d/g) ? search : undefined,
        },
        name: {
          contains: !!search && search.match(/[a-zA-Z]/) ? search : undefined,
          mode: 'insensitive',
        },
        priority: priority ? priority : undefined,
        tracing: tracing ? tracing : undefined,
      },
      take: Number(take) || 10,
      orderBy:
        Object.keys(orderByOptions).length > 0
          ? orderByOptions
          : { updatedAt: 'desc' },
    });
  }
  // OBTENER EXPEDIENTE POR ID`
  @Get(':id')
  findOne(@Param('id') id: number): Promise<RecordModel> {
    return this.recordsService.findOne({ id: Number(id) });
  }

  // ACTUALIZAR EXPEDIENTE POR ID
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRecordDto: UpdateRecordDto) {
    return this.recordsService.update(+id, updateRecordDto);
  }

  // ELIMINAR EXPEDIENTE POR ID
  @Delete(':id')
  remove(@Param('id') id: string): Promise<RecordModel> {
    return this.recordsService.remove({ id: Number(id) });
  }
}
