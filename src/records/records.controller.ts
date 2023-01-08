import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { RecordsService } from './records.service';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';
import { QueryDto } from './dto/query.dto';

import { Prisma, Record as RecordModel, Tracing } from '@prisma/client';
import { Priority } from '@prisma/client';

@Controller('records')
export class RecordsController {
  constructor(private readonly recordsService: RecordsService) {}

  // CREAR EXPEDIENTE
  @Post()
  async create(@Body() createRecordDto: CreateRecordDto): Promise<RecordModel> {
    return this.recordsService.create(createRecordDto);
  }

  // OBTENER TODOS LOS EXPEDIENTES
  @Get()
  findAll(): Promise<RecordModel[]> {
    return this.recordsService.findAll({});
  }

  // OBTENER TODOS LOS EXPEDIENTES
  @Get('filter')
  findFiltered(@Query() query: QueryDto): Promise<RecordModel[]> {
    if (/^\d/.test(query.search)) {
      // IF NUMBER COMPARE "search" WITH order
      return this.recordsService.findAll({
        where: {
          order: {
            contains: query.search,
          },
        },
      });
    } else {
      // IF NOT NUMBER COMPARE "search" WITH name
      return this.recordsService.findAll({
        where: {
          name: {
            contains: query.search,
            mode: 'insensitive',
          },
          priority: query.priority,
          tracing: query.tracing,
          archive: query.archive,
        },
        orderBy: {
          updatedAt: query.updatedAt,
        },
      });
    }
  }

  // OBTENER EXPEDIENTE POR ID`
  @Get(':id')
  findOne(@Param('id') id: string): Promise<RecordModel> {
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
